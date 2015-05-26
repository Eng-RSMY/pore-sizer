Flux = require 'reflux'
ParameterActions = require '../actions/parameter_actions'

ParameterStore = Flux.createStore
  listenables: ParameterActions

  init: ->
    @parameters =
      topology: null
      geometry: null
      phase: null
      physics: null

  onUpdatePhase: (newPhase) ->
    @parameters.phase = newPhase

  onUpdatePhysics: (newPhysics) ->
    @parameters.physics = newPhysics ->

  onUpdateTopology: (newTopology) ->
    @parameters.topology = newTopology

  onUpdateGeometry: (newGeometry) ->
    @parameters.geometry = newGeometry

module.exports = ParameterStore
