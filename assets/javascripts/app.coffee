Flux = require 'reflux'
React = require 'react'
GraphPanel = require './components/graph_panel'
PhasePanel = require './components/phase_panel'
ResultsStore = require './stores/results_store'
PhysicsPanel = require './components/physics_panel'
TopologyPanel = require './components/topology_panel'
GeometryPanel = require './components/geometry_panel'
ParameterStore = require './stores/parameter_store'
ParameterActions = require './actions/parameter_actions'
ExperimentalDataStore = require './stores/experimental_data_store'
ExperimentalDataActions = require './actions/experimental_data_actions'

PoreSizer = React.createClass
  mixins: [
    Flux.connect(ExperimentalDataStore, 'experimentalData')
    Flux.connect(ResultsStore, 'results')
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
      <GraphPanel experimentalData={@state.experimentalData} results={@state.results}/>
      <div className='eight wide column'>
        <TopologyPanel {...@state.parameters.topology} />
        <PhasePanel {...@state.parameters.phase} />
      </div>
      <div className='eight wide column'>
        <GeometryPanel {...@state.parameters.geometry} />
        <PhysicsPanel {...@state.parameters.physics} />
      </div>
    </div>

  _onUploadExperimentalData: (evt) ->
    file = evt.target.files[0]
    ExperimentalDataActions.upload(file)

module.exports = PoreSizer
