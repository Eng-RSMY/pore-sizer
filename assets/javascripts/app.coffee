Flux = require 'reflux'
React = require 'react'
AppStore = require './stores/app_store'
AppActions = require './actions/app_actions'
GraphPanel = require './components/graph_panel'
TopologyPanel = require './components/topology_panel'
GeometryPanel = require './components/geometry_panel'
ParametersStore = require './stores/parameter_store'

window.React = React
window.PoreSizer = {}

PoreSizer.App = React.createClass

  mixins: [Flux.listenTo(AppStore, 'onExperimentalDataChange')],

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
      <div className='two column row'>
        <TopologyPanel store={ParametersStore} />
        <GeometryPanel store={ParametersStore} />
      </div>
    </div>

  onExperimentalDataChange: (data) ->
    @setState(experimentalData: data)

  _onUploadExperimentalData: (evt) ->
    file = evt.target.files[0]
    AppActions.uploadExperimentalData(file)
