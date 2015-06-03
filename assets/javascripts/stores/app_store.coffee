Flux = require 'reflux'
AppActions = require '../actions/app_actions'
ParameterStore = require './parameter_store'

AppStore = Flux.createStore
  listenables: AppActions

  init: ->
    @experimentalData = []
    @results = []

    @listenTo(ParameterStore, @onValidatedInput)

    @PARSER_SETTINGS =
      dynamicTyping: true
      complete: (results, _) =>
        @experimentalData = results.data
        @trigger(@experimentalData)

  getInitialState: ->
    @experimentalData

  onUploadExperimentalData: (file) ->
    Papa.parse(file, @PARSER_SETTINGS)

  onValidatedInput: (parameters) ->


module.exports = AppStore
