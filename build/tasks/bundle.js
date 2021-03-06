var gulp = require('gulp');
var bundler = require('aurelia-bundler');
var bundles = require('../bundles.js');

var config = {
  force: true,
  packagePath: '.',
  bundles: bundles.bundles
};

// gulp.task('bundle', function() {
 gulp.task('bundle', ['unbundle', 'build','serve'], function() {
  return bundler.bundle(config);
});

gulp.task('unbundle', function() {
  return bundler.unbundle(config);
});
