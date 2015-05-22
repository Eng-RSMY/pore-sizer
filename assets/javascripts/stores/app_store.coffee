Flux = require 'reflux'
Papa = require 'papaparse'
AppActions = require '../actions/app_actions'

AppStore = Flux.createStore
  listenables: AppActions

  init: ->
    @experimentalData = []
    @PARSER_SETTINGS =
      dynamicTyping: true
      complete: (results, _) =>
        @experimentalData = results.data
        @trigger(@experimentalData)

  onUploadExperimentalData: (file) ->
    Papa.parse(file, @PARSER_SETTINGS)

module.exports = AppStore
