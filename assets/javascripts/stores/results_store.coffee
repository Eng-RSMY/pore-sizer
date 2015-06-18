Flux = require 'reflux'
Request = require 'superagent'
ResultsActions = require '../actions/results_actions'

ResultsStore = Flux.createStore
  listenables: ResultsActions

  init: ->
    @results = []

  getInitialState: ->
    @results

  onFetch: (parameters) ->
    Request.get('/sizer/op_simulation')
      .query(query: JSON.stringify(parameters))
      .set('Accept', 'application/json')
      .end (err, res) =>
        if err?
          return
        else
          debugger
          @results = JSON.parse(res.text).result
          @trigger(@results)

module.exports = ResultsStore
