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

vendorBundle = browserify
  debug: false
  insertGlobals: true
  detectGlobals: true

appBundle.require('./assets/javascripts/app.coffee', expose: 'poresizer')

dependencies.forEach (dep) ->
  appBundle.external(dep)
  vendorBundle.require(dep, expose: dep)

watchedApp = watchify(appBundle)
watchedApp.on('update', -> rebundle(watchedApp))
watchedApp.on('log', log)

rebundle = (b) ->
  b.bundle()
    .on('error', (err) => log(err))
    .pipe(source('app.js'))
    .pipe(buffer())
    .pipe(gulp.dest('./static'))

gulp.task('js', -> rebundle(appBundle))

gulp.task('js:watchify', -> rebundle(watchedApp))

gulp.task 'js:vendor', ->
  vendorBundle
    .bundle()
    .pipe(source('vendor.js'))
    .pipe(gulp.dest('./static'))
