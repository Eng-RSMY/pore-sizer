React = require 'react'
{updateGeometry} = require '../actions/parameter_actions'

GeometryPanel = React.createClass
  getInitialState: ->
    poreSeed: 'correlated'
    lx: null
    ly: null
    lz: null
    poreDiameter: 'logNormal'
    throatSeed: 'average'
    throatDiameter: 'logNormal'

  componentWillMount: ->
    updateGeometry(@state)

  render: ->
    <div className='ui eight wide column form'>
      <h4 className="ui top attached header">Geometry</h4>
      <div className='ui fluid bottom attached segment' onChange={@_onChange}>

        <div className='field'>
          <div className={if @props.errors.poreSeed then 'field error' else 'field'}>
            <label>Pore Seed</label>
            <select name='poreSeed' className='ui dropdown'>
              <option value='correlated'>Correlated</option>
              <option value='random'>Random</option>
            </select>
          </div>
        </div>

        { if @state.poreSeed == 'correlated'
          <div className='field'>
            <label>Correlation Distances</label>
            <div className='three fields'>
              <div className={if @props.errors.lx then 'field error' else 'field'}>
                <input name='lx' type='text' placeholder='Lx' />
              </div>

              <div className={if @props.errors.ly then 'field error' else 'field'}>
                <input name='ly' type='text' placeholder='Ly' />
              </div>

              <div className={if @props.errors.lz then 'field error' else 'field'}>
                <input name='lz' type='text' placeholder='Lz' />
              </div>
            </div>
          </div>
        }

        <div className='field'>
          <div className={if @props.errors.poreDiameter then 'field error' else 'field'}>
            <label>Pore Diameter</label>
            <select name='poreDiameter' className='ui dropdown'>
              <option value='logNormal'>Log Normal</option>
              <option value='normal'>Normal</option>
              <option value='random'>Random</option>
              <option value='weibull'>Weibull</option>
            </select>
          </div>
        </div>

        <div className='field'>
          <div className={if @props.errors.throatSeed then 'field error' else 'field'}>
            <label>Throat Seed</label>
            <select name='throatSeed' className='ui dropdown'>
              <option value='average'>Average</option>
              <option value='maximum'>Maximum</option>
              <option value='minimum'>Minimum</option>
            </select>
          </div>
        </div>

        <div className='field'>
          <div className={if @props.errors.throatDiameter then 'field error' else 'field'}>
            <label>Throat Diameter</label>
            <select name='throatDiameter' className='ui dropdown'>
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
    newState = do ->
      state = {}
      state[evt.target.name] = evt.target.value
      state
    @setState(newState, => updateGeometry(@state))

module.exports = GeometryPanel
