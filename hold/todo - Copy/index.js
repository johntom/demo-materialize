import {ObserverLocator} from 'aurelia-binding';
import {TodoItem} from './todo-item';
import _ from 'lodash';
import {   AuthServiceGTZ } from '../services';
import {api} from '../utils/api';
import {   inject } from 'aurelia-framework';
const ENTER_KEY = 13;
@inject( AuthServiceGTZ)
// const STORAGE_NAME = 'todomvc-aurelia';
export class Todos {
	static inject() { return [ObserverLocator]; }
	constructor(authgtz,observerLocator, storage = null) {
		this.items = [];
		this.filteredItems = [];
		this.filter = '';
		this.newTodoTitle = null;
		this.areAllChecked = false;

		this.observerLocator = observerLocator;
		this.storage = storage || localStorage;
        this.authgtz =authgtz;
		this.load();
	}

	activate(params) {
		this.updateFilteredItems(params.filter);
	}

	onKeyUp(ev) {
		if (ev.keyCode === ENTER_KEY) {
			this.addNewTodo(this.newTodoTitle);
		}
	}

	addNewTodo(title = this.newTodoTitle) {
		if (title == undefined) { return; }

		title = title.trim();
		if (title.length === 0) { return; }

		const newTodoItem = new TodoItem(title);
		this.observeItem(newTodoItem);
		this.items.push(newTodoItem);
		this.newTodoTitle = null;
		this.updateAreAllCheckedState();
		this.updateFilteredItems(this.filter);
		this.save();
	}

	observeItem(todoItem) {
		this.observerLocator
			.getObserver(todoItem, 'title')
			.subscribe((o, n) => this.onTitleChanged(todoItem));

		this.observerLocator
			.getObserver(todoItem, 'isCompleted')
			.subscribe(() => this.onIsCompletedChanged());
	}

	onTitleChanged(todoItem) {
		if (todoItem.title === '') {
			this.deleteTodo(todoItem);
			this.updateAreAllCheckedState();
		}

		this.save();
	}

	onIsCompletedChanged() {
		this.updateAreAllCheckedState();
		this.updateFilteredItems(this.filter);

		this.save();
	}

	deleteTodo(todoItem) {
		this.items = _(this.items).without(todoItem);
		this.updateAreAllCheckedState();
		this.updateFilteredItems(this.filter);
		this.save();
	}

	onToggleAllChanged() {
		this.items = _.map(this.items, item => {
			item.isCompleted = this.areAllChecked;
			return item;
		});

		this.updateFilteredItems(this.filter);
	}

	clearCompletedTodos() {
		this.items = _(this.items).filter(i => !i.isCompleted);
		this.areAllChecked = false;
		this.updateFilteredItems(this.filter);
		this.save();
	}

	get countTodosLeft() {
		return _(this.items).filter(i => !i.isCompleted).length;
	}

	updateAreAllCheckedState() {
		this.areAllChecked = _(this.items).all(i => i.isCompleted);
	}

	updateFilteredItems(filter) {
		this.filter = filter || '!';

		switch (filter) {
			case 'active':
				this.filteredItems = _(this.items).filter(i => !i.isCompleted);
				break;
			case 'completed':
				this.filteredItems = _(this.items).filter(i =>	i.isCompleted);
				break;
			default:
				this.filteredItems = this.items;
				break;
		}
	}

	load() {
		// const storageContent = this.storage.getItem(STORAGE_NAME);
		// if (storageContent == undefined) { return; }

		// const simpleItems = JSON.parse(storageContent);
             let token= this.authgtz.token;
             let user= this.authgtz.user;
             let userid= 11832;//this.authgtz.loginuserid;
             
    //   var  userid =this.props.data.userid;
    //    var  token = this.props.data.token;
                api.getTodostoken(userid,token)
                   .then((jsonRes) => {
                
             const simpleItems = jsonRes.data;// JSON.parse(storageContent);
            //  const simpleItems = JSON.parse(jsonRes.data);
            console.log('simpleItems ',simpleItems)
            //    });
          
        
		this.items = _.map(simpleItems, item => {
			const todoItem = new TodoItem(item.title);
			todoItem.isCompleted = item.completed;

			this.observeItem(todoItem);

			return todoItem;
		});
		this.updateAreAllCheckedState();
        // this.filteredItems =simpleItems;
           });
	}

	save() {
		const simpleItems = _.map(this.items, item => { return {
			title: item.title,
			completed: item.isCompleted
		}});

		//this.storage.setItem(STORAGE_NAME, JSON.stringify(simpleItems));
	}
}
