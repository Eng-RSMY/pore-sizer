Flux = require 'reflux'
schema = require '../lib/schema'
ParameterActions = require '../actions/parameter_actions'

ParameterStore = Flux.createStore
  listenables: ParameterActions

  init: ->
    @schema = schema
    @parameters =
      topology: {}
      geometry: {}
      phase: {}
      physics: {}

    @errors =
      topology: {}
      geometry: {}
      phase: {}
      physics: {}

  getInitialState: ->
    @errors

  onUpdatePhase: (newPhase) ->
    @parameters.phase = newPhase

  onUpdatePhysics: (newPhysics) ->
    @parameters.physics = newPhysics ->

  onUpdateTopology: (newTopology) ->
    @parameters.topology = newTopology

  onUpdateGeometry: (newGeometry) ->
    @parameters.geometry = newGeometry

  onValidate: ->
    result = Joi.validate(@parameters, @schema, {abortEarly: false})
    _.each(result.error.details, (d) => _.set(@errors, d.path, d.message))
    @trigger(@errors)

module.exports = ParameterStore
