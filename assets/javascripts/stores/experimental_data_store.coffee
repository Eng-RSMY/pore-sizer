Flux = require 'reflux'
Papa = require 'papaparse'
ExperimentalDataActions = require '../actions/experimental_data_actions'

ExperimentalDataStore = Flux.createStore
  listenables: ExperimentalDataActions

  init: ->
    @experimentalData = []

    @PARSER_SETTINGS =
      dynamicTyping: true
      complete: (results, _) =>
        @experimentalData = results.data
        @trigger(@experimentalData)

  getInitialState: ->
    @experimentalData

  onUpload: (file) ->
    Papa.parse(file, @PARSER_SETTINGS)

module.exports = ExperimentalDataStore
