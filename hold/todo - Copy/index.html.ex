<template>
     <!--<link rel="stylesheet" type="text/css" href="jspm_packages/npm/todomvc-common@1.0.2/base.css">
  <link rel="stylesheet" type="text/css" href="jspm_packages/npm/todomvc-app-css@2.0.4/index.css">-->
  <section class="todoapp">
    <header class="header">
      <h1>todos</h1>

      <form role="form" submit.delegate="addTodo(todo)">
        <input class="new-todo" placeholder="What needs to be done?" value.bind="todo.title" autofocus>
      </form>
    </header>

    <!-- This section should be hidden by default and shown when there are todos -->
    <section class="main" show.bind="todos.length">
      <input class="toggle-all" type="checkbox" click.delegate="toggleAll(todos)" checked.one-way="allCompleted">
      <label for="toggle-all">Mark all as complete</label>
      <ul class="todo-list">
        <!-- These are here just to show the structure of the list items -->
        <!-- List items should get the class `editing` when editing and `completed` when marked as completed -->
        <li repeat.for="t of todos" class="${t.completed ? 'completed' : ''} ${t.editing ? 'editing' : '' }">
          <div class="view">
            <input class="toggle" type="checkbox" checked.bind="t.completed" click.delegate="saveTodo(t)">
            <label dblclick.delegate="$parent.editTodo(t)">${t.title}</label>
            <button class="destroy" click.delegate="removeTodo(t)"></button>
          </div>
          <form role="form" submit.delegate="saveTodo(t)">
            <input class="edit" value.bind="t.title">
          </form>
        </li>
      </ul>
    </section>
    <!-- This footer should hidden by default and shown when there are todos --> 
    <footer class="footer">
      <!-- This should be `0 items left` by default -->
      <span class="todo-count"><strong>${todos.length}</strong> item${todos.length !== 1 ? 's' : ''} left</span>
      <!-- Remove this if you don't implement routing -->
      <!--
      <ul class="filters">
        <li>
          <a class="selected" href="#/">All</a>
        </li>
        <li>
          <a href="#/active">Active</a>
        </li>
        <li>
          <a href="#/completed">Completed</a>
        </li>
      </ul>
      -->
      <!-- Hidden if no completed items are left ↓ -->
      <button class="clear-completed" click.delegate="clearCompleted(todos)" show.bind="hasCompleted">Clear completed</button>
    </footer>
  </section>

  <footer class="info">
    <p>Double-click to edit a todo</p>
    <p>Created by <a href="http://freya.sk">Martin Jantošovič</a></p>
    <p>Part of <a href="http://todomvc.com">TodoMVC</a></p>
  </footer>
  </section>
</template>
<template>
  <section class="todoapp">
    <header class="header">
      <h1>todos</h1>

      <form role="form" submit.delegate="addTodo(todo)">
        <input class="new-todo" placeholder="What needs to be done?" value.bind="todo.title" autofocus>
      </form>
    </header>

    <!-- This section should be hidden by default and shown when there are todos -->
    <section class="main" show.bind="todos.length">
      <input class="toggle-all" type="checkbox" click.delegate="toggleAll(todos)" checked.one-way="allCompleted">
      <label for="toggle-all">Mark all as complete</label>
      <ul class="todo-list">
        <!-- These are here just to show the structure of the list items -->
        <!-- List items should get the class `editing` when editing and `completed` when marked as completed -->
        <li repeat.for="t of todos" class="${t.completed ? 'completed' : ''} ${t.editing ? 'editing' : '' }">
          <div class="view">
            <input class="toggle" type="checkbox" checked.bind="t.completed" click.delegate="saveTodo(t)">
            <label dblclick.delegate="$parent.editTodo(t)">${t.title}</label>
            <button class="destroy" click.delegate="removeTodo(t)"></button>
          </div>
          <form role="form" submit.delegate="saveTodo(t)">
            <input class="edit" value.bind="t.title">
          </form>
        </li>
      </ul>
    </section>
    <!-- This footer should hidden by default and shown when there are todos --> 
    <footer class="footer">
      <!-- This should be `0 items left` by default -->
      <span class="todo-count"><strong>${todos.length}</strong> item${todos.length !== 1 ? 's' : ''} left</span>
      <!-- Remove this if you don't implement routing -->
      <!--
      <ul class="filters">
        <li>
          <a class="selected" href="#/">All</a>
        </li>
        <li>
          <a href="#/active">Active</a>
        </li>
        <li>
          <a href="#/completed">Completed</a>
        </li>
      </ul>
      -->
      <!-- Hidden if no completed items are left ↓ -->
      <button class="clear-completed" click.delegate="clearCompleted(todos)" show.bind="hasCompleted">Clear completed</button>
    </footer>
  </section>

  <footer class="info">
    <p>Double-click to edit a todo</p>
    <p>Created by <a href="http://freya.sk">Martin Jantošovič</a></p>
    <p>Part of <a href="http://todomvc.com">TodoMVC</a></p>
  </footer>
  </section>
</template>
