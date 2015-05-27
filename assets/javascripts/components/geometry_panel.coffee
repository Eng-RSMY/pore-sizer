React = require 'react'
{updateGeometry} = require '../actions/parameter_actions'

GeometryPanel = React.createClass

  render: ->
    <div className='ui eight wide column form'>
      <h4 className="ui top attached header">Geometry</h4>
      <div className='ui fluid bottom attached segment' onChange={@_onChange}>

        <div className='two fields'>
          <div className='field'>
            <label>Pore Seed</label>
            <select ref='poreSeed' className='ui dropdown'>
              <option value='correlated'>Correlated</option>
              <option value='random'>Random</option>
            </select>
          </div>

          <div className='field'>
            <label>Pore Diameter</label>
            <div className='ui right labeled input'>
              <input ref='poreDiameter' type='text' placeholder='Ex. 0.1' />
              <div className='ui label'>mm</div>
            </div>
          </div>
        </div>

        <div className='two fields'>
          <div className='field'>
            <label>Throat Seed</label>
            <select ref='throatSeed' className='ui dropdown'>
              <option value='correlated'>Correlated</option>
              <option value='random'>Random</option>
            </select>
          </div>
          <div className='field'>
            <label>Throat Diameter</label>
            <div className='ui right labeled input'>
              <input ref='throatDiameter' type='text' placeholder='Ex. 0.1' />
              <div className='ui label'>mm</div>
            </div>
          </div>
        </div>
      </div>
    </div>

  _onChange: ->
    poreSeedNode = @refs.poreSeed.getDOMNode()
    poreSeed = poreSeedNode.options[poreSeedNode.selectedIndex].value
    poreDiameter = @refs.poreDiameter.getDOMNode().value

    throatSeedNode = @refs.throatSeed.getDOMNode()
    throatSeed = throatSeedNode.options[throatSeedNode.selectedIndex].value
    throatDiameter = @refs.throatDiameter.getDOMNode().value

    updateGeometry
      poreSeed: poreSeed
      poreDiameter: poreDiameter
      throatSeed: throatSeed
      throatDiameter: throatDiameter

module.exports = GeometryPanel
