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
    Request.get('/sizer/distribution')
      .query(query: JSON.stringify(parameters))
      .set('Accept', 'application/json')
      .end (err, res) =>
        debugger
        if err?
          return
        else
          @results = res.body
          @trigger(@results)

module.exports = ResultsStore
