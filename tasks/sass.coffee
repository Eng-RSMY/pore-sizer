gulp = require 'gulp'
sass = require 'gulp-sass'

buildDir = './assets/build'

gulp.task 'sass', ->
  gulp.src('./assets/stylesheets/app.scss')
    .pipe(sass())
    .pipe(gulp.dest(buildDir))
