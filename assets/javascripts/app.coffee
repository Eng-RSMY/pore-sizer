Flux = require 'reflux'
React = require 'react'
AppStore = require './stores/app_store'
AppActions = require './actions/app_actions'
GraphPanel = require './components/graph_panel'
PhasePanel = require './components/phase_panel'
PhysicsPanel = require './components/physics_panel'
TopologyPanel = require './components/topology_panel'
GeometryPanel = require './components/geometry_panel'
ParameterStore = require './stores/parameter_store'
ParameterActions = require './actions/parameter_actions'

PoreSizer = React.createClass
  mixins: [
    Flux.connect(AppStore, 'experimentalData')
    Flux.connect(ParameterStore, 'parameters')
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

        <div className='ui teal button' onClick={ParameterActions.validate}>Run</div>
      </div>
      <GraphPanel experimentalData={@state.experimentalData} />
      <div className='two column equal height row'>
        <TopologyPanel {...@state.parameters.topology} />
        <GeometryPanel {...@state.parameters.geometry} />
      </div>
      <div className='two column equal height row'>
        <PhasePanel {...@state.parameters.phase} />
        <PhysicsPanel {...@state.parameters.physics} />
      </div>
    </div>

  _onUploadExperimentalData: (evt) ->
    file = evt.target.files[0]
    AppActions.uploadExperimentalData(file)

module.exports = PoreSizer
