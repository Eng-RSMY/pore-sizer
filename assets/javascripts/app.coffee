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

window.React = React
window.PoreSizer = {}

PoreSizer.App = React.createClass

  mixins: [Flux.listenTo(AppStore, '_onExperimentalDataChange')],

  getInitialState: ->
    experimentalData: []

  render: ->
    <div className='ui page grid'>
      <div className='row'>
        <label htmlFor='fileUpload' className='ui icon button'>
          <i className='file icon'></i>
          Upload a CSV file
        </label>
        <input type='file' id='fileUpload' style={{display: 'none'}}
               onChange={@_onUploadExperimentalData} />
      </div>
      <GraphPanel experimentalData={@state.experimentalData} />
      <div className='two column equal height row'>
        <TopologyPanel store={ParameterStore} />
        <GeometryPanel store={ParameterStore} />
      </div>
      <div className='two column equal height row'>
        <PhasePanel store={ParameterStore} />
        <PhysicsPanel store={ParameterStore} />
      </div>
    </div>

  _onExperimentalDataChange: (data) ->
    @setState(experimentalData: data)

  _onUploadExperimentalData: (evt) ->
    file = evt.target.files[0]
    AppActions.uploadExperimentalData(file)
