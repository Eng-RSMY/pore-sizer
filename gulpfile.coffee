gulp = require 'gulp'
requireDir = require 'require-dir'

requireDir './tasks'

gulp.task 'default', ['js', 'sass']

gulp.task 'watch', ->
  gulp.watch('./assets/javascripts/**/*.cjsx', ['js'])
  gulp.watch('./assets/stylesheets/**/*.scss', ['sass'])
