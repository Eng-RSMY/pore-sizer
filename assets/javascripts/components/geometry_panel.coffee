React = require 'react'
{updateGeometry} = require '../actions/parameter_actions'

GeometryPanel = React.createClass
  render: ->
    <div className='ui eight wide column form'>
      <h4 className="ui top attached header">Geometry</h4>
      <div className='ui fluid bottom attached segment' onChange={@_onChange}>

        <div className='field'>
          <div className='field'>
            <label>Pore Seed</label>
            <select name='poreSeed' value={@props.poreSeed} className='ui dropdown'>
              <option value='correlated'>Correlated</option>
              <option value='random'>Random</option>
            </select>
          </div>
        </div>

        { if @props.poreSeed == 'correlated'
          <div className='field'>
            <label>Correlation Distances</label>
            <div className='three fields'>
              <div className={if @props.lx?.error then 'field error' else 'field'}>
                <input name='lx' type='text' placeholder='Lx' />
              </div>

              <div className={if @props.ly?.error then 'field error' else 'field'}>
                <input name='ly' type='text' placeholder='Ly' />
              </div>

              <div className={if @props.lz?.error then 'field error' else 'field'}>
                <input name='lz' type='text' placeholder='Lz' />
              </div>
            </div>
          </div>
        }

        <div className='field'>
          <div className='field'>
            <label>Pore Diameter</label>
            <select name='poreDiameter' value={@props.poreDiameter} className='ui dropdown'>
              <option value='logNormal'>Log Normal</option>
              <option value='normal'>Normal</option>
              <option value='random'>Random</option>
              <option value='weibull'>Weibull</option>
            </select>
          </div>
        </div>

        <div className='field'>
          <div className='field'>
            <label>Throat Seed</label>
            <select name='throatSeed' value={@props.throatSeed} className='ui dropdown'>
              <option value='average'>Average</option>
              <option value='maximum'>Maximum</option>
              <option value='minimum'>Minimum</option>
            </select>
          </div>
        </div>

        <div className='field'>
          <div className='field'>
            <label>Throat Diameter</label>
            <select name='throatDiameter' name={@props.throatDiameter} className='ui dropdown'>
              <option value='logNormal'>Log Normal</option>
              <option value='normal'>Normal</option>
              <option value='random'>Random</option>
              <option value='weibull'>Weibull</option>
            </select>
          </div>
        </div>
      </div>
    </div>

  _onChange: (evt) ->
    value = if evt.target.value == '' then null else evt.target.value
    updateGeometry(evt.target.name, value)

module.exports = GeometryPanel
