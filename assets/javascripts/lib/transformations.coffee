module.exports =
  topology:
    height: (d) -> parseInt(d)
    width: (d) -> parseInt(d)
    depth: (d) -> parseInt(d)
    size: (d) -> parseInt(d)
    connections: (d) -> parseInt(d)
  geometry:
    lx: (d) -> parseInt(d)
    ly: (d) -> parseInt(d)
    lz: (d) -> parseInt(d)
  phase:
    surfaceTension: (d) -> parseFloat(d)
    contactAngle: (d) -> parseFloat(d)
