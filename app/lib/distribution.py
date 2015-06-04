from OpenPNM.Network import Cubic
from OpenPNM.Geometry import GenericGeometry
from OpenPNM.Geometry.models import pore_seed, pore_diameter, throat_seed, throat_diameter
ctrl = OpenPNM.Base.Controller()

def distribution(params):
  topo = params.topology
  geo = params.geometry
  phs = params.phase
  phys = params.physics

  pn = Cubic(size=[topo.height, topo.width, topo.depth])
  geometry = GenericGeometry(network=pn, pores=pn.pores(), throats=pn.throats())
  geometry.add_model(**_pore_seed_model())
  geometry.add_model(**_pore_diameter_model())

def _pore_seed_model(geo):
  model = {
    propname: 'pore.seed',
    model: pore_seed.spatially_correlated
  }

  if geo.poreSeed == 'correlated'
    model['weights'] = [geo.lx, geo.ly, geo.lz]
  elif geo.poreSeed == 'random'
    model['weights'] = [0, 0, 0]

  return model

def _pore_diameter_model(geo):
  model = {
    propname: 'pore.diameter',
    model:
  }
