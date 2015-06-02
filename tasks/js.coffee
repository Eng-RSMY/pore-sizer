gulp = require 'gulp'
{log} = require 'gulp-util'
buffer = require 'vinyl-buffer'
source = require 'vinyl-source-stream'
watchify = require 'watchify'
browserify = require 'browserify'
coffeeReact = require 'coffee-reactify'
dependencies = Object.keys(require('../package.json').dependencies)

appBundle = browserify
  debug: true
  extensions: ['.coffee']
  transform: [coffeeReact]

dependencies.forEach (dep) -> appBundle.external(dep)

w = watchify(appBundle)

vendorBundle = browserify
  debug: false
  insertGlobals: true
  detectGlobals: true

dependencies.forEach (dep) -> vendorBundle.require(dep, expose: dep)

rebundle = ->
  w.bundle()
    .on('error', (err) -> log(err))
    .pipe(source('app.js'))
    .pipe(buffer())
    .pipe(gulp.dest('./static'))

gulp.task 'js', ->
  appBundle.require('./assets/javascripts/app.coffee', expose: 'poresizer')
    .bundle()
    .pipe(source('app.js'))
    .pipe(buffer())
    .pipe(gulp.dest('./static'))

gulp.task 'js:watchify', ->
  w.on('update', rebundle)
    .on('log', (message) -> log("[Watchify] #{message}"))
  rebundle()

gulp.task 'js:vendor', ->
  vendorBundle
    .bundle()
    .pipe(source('vendor.js'))
    .pipe(gulp.dest('./static'))
