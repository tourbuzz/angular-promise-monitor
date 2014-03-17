angular.module('promiseMonitor', [])
  .factory('$promiseMonitor', ['$q', ($q) ->
    promises = {}
    monitorDefered = $q.defer()
    notify = (promiseScope='default') ->
      monitorDefered.notify(promises[promiseScope].length)
    {
      registerPromise: (p, promiseScope='default') ->
        promises[promiseScope] ||= []
        promises[promiseScope].push(p)
        notify(promiseScope)
        promise["finally"](->
          promises[promiseScope]
            .splice(promises[promiseScope].indexOf(p), 1)
          notify(promiseScope)
        )
      ,
      pending: (promiseScope='default') ->
        promises[promiseScope].length
      ,
      promise: ->
        monitorDefered.promise
    }
  ])
