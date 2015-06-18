from OpenPNM.Base import Controller
from OpenPNM.Network import Cubic
from OpenPNM.Phases import GenericPhase
from OpenPNM.Physics import GenericPhysics
from OpenPNM.Geometry import GenericGeometry
from OpenPNM.Algorithms import OrdinaryPercolation
from OpenPNM.Geometry import models as gm
from OpenPNM.Physics import models as pm
import scipy as sp
from numpy import dstack

controller = Controller()

def run(params):
  controller.clear()

  topo = params['topology']
  geo = params['geometry']
  phs = params['phase']
  phys = params['physics']

  network = Cubic(shape=[topo['height'], topo['width'], topo['depth']])

  geometry = GenericGeometry(network=network,
                             pores=network.pores(),
                             throats=network.throats())
  geometry.add_model(geometry=geometry, **_pore_seed_model(geo))
  geometry.add_model(geometry=geometry, **_pore_diameter_model(geo))
  geometry.add_model(geometry=geometry, **_pore_volume_model())
  geometry.add_model(geometry=geometry, **_throat_seed_model(geo))
  geometry.add_model(geometry=geometry, **_throat_diameter_model(geo))
  geometry.add_model(geometry=geometry, **_throat_length_model())
  geometry.add_model(geometry=geometry, **_throat_volume_model())

  invading_phase = GenericPhase(network=network, name='invading')
  defending_phase = GenericPhase(network=network, name='defending')

  if phs['type'] == 'custom':
    invading_phase['pore.contact_angle'] = phs['contactAngle']
    invading_phase['pore.surface_tension'] = phs['surfaceTension']
    defending_phase['pore.contact_angle'] = phs['contactAngle']
    defending_phase['pore.surface_tension'] = phs['surfaceTension']

  invading_physics = GenericPhysics(network=network,
                                    phase=invading_phase,
                                    geometry=geometry)
  defending_physics = GenericPhysics(network=network,
                                     phase=defending_phase,
                                     geometry=geometry)

  invading_physics.add_model(**_capillary_pressure_model(phys))
  defending_physics.add_model(**_capillary_pressure_model(phys))

  algorithm = OrdinaryPercolation(network=network,
                                  invading_phase=invading_phase,
                                  defending_phase=defending_phase)

  algorithm.run(inlets=network.pores('top'))

  return {
    'invasion_pressures': _transform_data(algorithm).tolist(),
    'pore_volumes': geometry['pore.volume'].tolist()
  }

def _transform_data(algorithm):
  pore_invasion_pressures = sp.unique(algorithm['pore.inv_Pc'])
  invaded_volume_fraction = sp.zeros_like(pore_invasion_pressures)
  pores = algorithm._net.pores(labels='all')
  pore_volumes = algorithm._net['pore.volume']
  total_pore_volume = sum(pore_volumes)

  for i, pressure in enumerate(pore_invasion_pressures):
    invaded_pores = pore_volumes[algorithm._p_inv[pores] <= pressure]
    invaded_volume_fraction[i] = sum(invaded_pores) / total_pore_volume

  return dstack((pore_invasion_pressures, invaded_volume_fraction))[0]

def _pore_seed_model(geo):
  model = {
    'propname': 'pore.seed',
    'model': gm.pore_seed.spatially_correlated
  }

  if geo['poreSeed'] == 'correlated':
    model['weights'] = [geo['lx'], geo['ly'], geo['lz']]
  elif geo['poreSeed'] == 'random':
    model['weights'] = [0, 0, 0]

  return model

def _pore_diameter_model(geo):
  model = {
    'propname': 'pore.diameter',
    'model': gm.pore_diameter.sphere,
    'psd_scale': 1,
    'psd_shape': 1
  }
  if geo['poreDiameter'] == 'normal':
    model['psd_name'] = 'norm'
    model['psd_loc'] = 6.9e-7
  elif geo['poreDiameter'] == 'random':
    return
  elif geo['poreDiameter'] == 'logNormal':
    return
  elif geo['poreDiameter'] == 'weibull':
    model['psd_name'] = 'weibull_min'
    model['psd_loc'] = 6.9e-7

  return model

def _pore_volume_model():
  model = {
    'propname': 'pore.volume',
    'model': gm.pore_volume.sphere
  }
  return model

def _throat_seed_model(geo):
  model = {
    'propname': 'throat.seed',
    'model': gm.throat_seed.random
  }
  return model

def _throat_diameter_model(geo):
  model = {
    'propname': 'throat.diameter',
    'model': gm.throat_diameter.cylinder,
    'tsd_scale': 1,
    'tsd_shape': 1
  }

  if geo['throatDiameter'] == 'normal':
    model['tsd_name'] = 'norm'
    model['tsd_loc'] = 6.9e-7
  elif geo['throatDiameter'] == 'random':
    return
  elif geo['throatDiameter'] == 'logNormal':
    return
  elif geo['throatDiameter'] == 'weibull':
    model['tsd_name'] = 'weibull_min'
    model['tsd_loc'] = 6.9e-7

  return model

def _throat_volume_model():
  model = {
    'propname': 'throat.volume',
    'model': gm.throat_volume.cylinder
  }
  return model

def _throat_length_model():
  model = {
    'propname': 'throat.length',
    'model': gm.throat_length.straight
  }
  return model

def _capillary_pressure_model(phys):
  model = {
    'propname': 'throat.capillary_pressure',
    'model': pm.capillary_pressure.purcell,
    'r_toroid': 1.e-5
  }
  return model
