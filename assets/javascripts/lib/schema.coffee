Joi = require 'joi'

module.exports = Joi.object().keys
  topology:
    height: Joi.number().integer().required()
    width: Joi.number().integer().required()
    depth: Joi.number().integer().required()
    size: Joi.number().integer().required()
    connections: Joi.number().integer().required()

  geometry:
    poreSeed: Joi.string().required()
    lx: Joi.number().integer().when('poreSeed', {is: 'correlated', then: Joi.required()})
    ly: Joi.number().integer().when('poreSeed', {is: 'correlated', then: Joi.required()})
    lz: Joi.number().integer().when('poreSeed', {is: 'correlated', then: Joi.required()})
    poreDiameter: Joi.string().required()
    throatSeed: Joi.string().required()
    throatDiameter: Joi.string().required()

  phase:
    type: Joi.string().required()
    surfaceTension: Joi.number().when('type', {is: 'custom', then: Joi.required()})
    contactAngle: Joi.number().when('type', {is: 'custom', then: Joi.required()})

  physics:
    capillaryPressure: Joi.string().required()
