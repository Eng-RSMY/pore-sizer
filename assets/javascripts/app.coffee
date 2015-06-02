Flux = require 'reflux'
React = require 'react'
AppStore = require './stores/app_store'
AppActions = require './actions/app_actions'
GraphPanel = require './components/graph_panel'
PhasePanel = require './components/phase_panel'
{validate} = require './actions/parameter_actions'
PhysicsPanel = require './components/physics_panel'
TopologyPanel = require './components/topology_panel'
GeometryPanel = require './components/geometry_panel'
ParameterStore = require './stores/parameter_store'

module.exports = React.createClass
  mixins: [
    Flux.connect(AppStore, 'experimentalData')
    Flux.connect(ParameterStore, 'errors')
  ]

  render: ->
    <div className='ui page grid'>
      <div className='row'>
        <label htmlFor='fileUpload' className='ui icon button'>
          <i className='file icon'></i>
          Upload a CSV file
        </label>
        <input type='file' id='fileUpload' style={{display: 'none'}}
               onChange={@_onUploadExperimentalData} />

        <div className='ui teal button' onClick={validate}>Run</div>
      </div>
      <GraphPanel experimentalData={@state.experimentalData} />
      <div className='two column equal height row'>
        <TopologyPanel errors={@state.errors.topology} />
        <GeometryPanel errors={@state.errors.geometry} />
      </div>
      <div className='two column equal height row'>
        <PhasePanel errors={@state.errors.phase} />
        <PhysicsPanel errors={@state.errors.physics} />
      </div>
    </div>

  _onUploadExperimentalData: (evt) ->
    file = evt.target.files[0]
    AppActions.uploadExperimentalData(file)
