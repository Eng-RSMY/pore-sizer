React = require 'react'
{updateTopology} = require '../actions/parameter_actions'

TopologyPanel = React.createClass
  render: ->
    <div className='ui eight wide column form'>
      <h4 className="ui top attached header">Topology</h4>
      <div className='ui fluid bottom attached segment'>

        <div className='field'>
          <label>Dimensions</label>
          <div className='three fields'>
            <div className='field'>
              <input type='text' placeholder='Height' />
            </div>

            <div className='field'>
              <input type='text' placeholder='Width' />
            </div>

            <div className='field'>
              <input type='text' placeholder='Depth' />
            </div>
          </div>
        </div>

        <div className='two fields'>
          <div className='field'>
            <label>Size</label>
            <input type='text' placeholder='Ex. 100' />
          </div>

          <div className='field'>
            <label>Connections</label>
            <input type='text' placeholder='Ex. 6' />
          </div>
        </div>
      </div>
    </div>

module.exports = TopologyPanel
