gulp = require 'gulp'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
browserify = require 'browserify'
coffeeReact = require 'coffee-reactify'

browserifySettings =
  entries: './assets/javascripts/app.coffee'
  debug: true
  transform: [coffeeReact]

gulp.task 'js', ->
  browserify(browserifySettings)
    .bundle()
    .pipe(source('app.js'))
    .pipe(buffer())
    .pipe(gulp.dest('./static'))
