gulp = require 'gulp'
requireDir = require 'require-dir'

requireDir './tasks'

gulp.task 'default', ['js', 'css']

gulp.task 'watch', ->
  gulp.watch('./assets/javascripts/**/*.cjsx', ['js'])
  gulp.watch('./assets/javascripts/**/*.coffee', ['js'])
  gulp.watch('./assets/javascripts/*.css', ['css'])
