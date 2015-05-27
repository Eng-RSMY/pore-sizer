Joi = require 'joi'
Flux = require 'reflux'
schema = require '../lib/schema'
ParameterActions = require '../actions/parameter_actions'

ParameterStore = Flux.createStore
  listenables: ParameterActions

  init: ->
    @schema = schema
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

  onValidate: ->
    Joi.validate @parameters, @schema, (err, value) =>
      debugger

window.log = -> console.log ParameterStore.parameters
module.exports = ParameterStore
