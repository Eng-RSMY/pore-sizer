Flux = require 'reflux'
window.React = require 'react'
AppStore = require './stores/app_store'
AppActions = require './actions/app_actions'
GraphPanel = require './components/graph_panel'

window.PoreSizer = {}

PoreSizer.App = React.createClass

  mixins: [Flux.listenTo(AppStore, 'onExperimentalDataChange')],

  getInitialState: ->
    experimentalData: []

  render: ->
    <div className='ui two column page grid'>
      <div className='three wide column' />
      <div className='ui grid'>
        <div className='row'>
          <label htmlFor='fileUpload' className='ui icon button'>
            <i className='file icon'></i>
            Upload a CSV file
          </label>
          <input type='file' id='fileUpload' style={{display: 'none'}}
                 onChange={@_onUploadExperimentalData} />
        </div>
        <GraphPanel experimentalData={@state.experimentalData} />
      </div>
    </div>

  onExperimentalDataChange: (data) ->
    debugger
    @setState(experimentalData: data)

  _onUploadExperimentalData: (evt) ->
    file = evt.target.files[0]
    AppActions.uploadExperimentalData(file)
