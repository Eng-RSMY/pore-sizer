gulp       = require 'gulp'
coffeelint = require 'gulp-coffeelint'

gulp.task 'coffeelint', ->
  gulp.src('./assets/javascripts/**/**')
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())
