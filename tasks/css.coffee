gulp = require 'gulp'
sass = require 'gulp-sass'

gulp.task 'css', ->
  gulp.src('./assets/stylesheets/app.scss')
    .pipe(sass())
    .pipe(gulp.dest('./static'))
