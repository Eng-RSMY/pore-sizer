Joi = require 'joi'

module.exports = Joi.object().keys
  topology:
    height: Joi.number().integer().required()
    width: Joi.number().integer().required()
    depth: Joi.number().integer().required()
    size: Joi.number().integer().required()
    connectivity: Joi.number().integer().required()

  geometry:
    poreSeed: Joi.string().required()
    lx: Joi.number().integer().when('poreSeed', {
      is: 'correlated'
      then: Joi.required()
      otherwise: Joi.allow(null)
    })
    ly: Joi.number().integer().when('poreSeed', {
      is: 'correlated'
      then: Joi.required()
      otherwise: Joi.allow(null)
    })
    lz: Joi.number().integer().when('poreSeed', {
      is: 'correlated'
      then: Joi.required()
      otherwise: Joi.allow(null)
    })
    poreDiameter: Joi.string().required()
    throatSeed: Joi.string().required()
    throatDiameter: Joi.string().required()

  phase:
    type: Joi.string().required()
    surfaceTension: Joi.number().when('type', {
      is: 'custom'
      then: Joi.required()
      otherwise: Joi.allow(null)
    })
    contactAngle: Joi.number().when('type', {
      is: 'custom'
      then: Joi.required()
      otherwise: Joi.allow(null)
    })

  physics:
    capillaryPressure: Joi.string().required()
