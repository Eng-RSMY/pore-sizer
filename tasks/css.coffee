gulp = require 'gulp'
concat = require 'gulp-concat'

gulp.task 'css', ->
  gulp.src('./assets/stylesheets/*.css')
    .pipe(concat('app.css'))
    .pipe(gulp.dest('./static'))
