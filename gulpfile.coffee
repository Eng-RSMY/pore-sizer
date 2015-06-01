gulp = require 'gulp'
requireDir = require 'require-dir'

requireDir './tasks'

gulp.task 'default', ['js', 'css']

gulp.task 'watch', ['js:watchify'], ->
  gulp.watch('./assets/stylesheets/*.scss', ['css'])
