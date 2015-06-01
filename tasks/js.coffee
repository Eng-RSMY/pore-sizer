gulp = require 'gulp'
{log} = require 'gulp-util'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
watchify = require 'watchify'
browserify = require 'browserify'
coffeeReact = require 'coffee-reactify'

b = browserify
  entries: './assets/javascripts/app.coffee'
  debug: true
  noparse: ['lodash', 'd3', 'papaparse']
  extensions: ['.coffee']
  transform: [coffeeReact]

w = watchify(b)

rebundle = ->
  w.bundle()
    .on('error', (err) -> log(err))
    .pipe(source('app.js'))
    .pipe(buffer())
    .pipe(gulp.dest('./static'))

gulp.task 'js', ->
  browserify(browserifySettings)
    .bundle()
    .pipe(source('app.js'))
    .pipe(buffer())
    .pipe(gulp.dest('./static'))

gulp.task 'js:watchify', ->
  w.on('update', rebundle)
    .on('log', (message) -> log("[Watchify] #{message}"))
  rebundle()
