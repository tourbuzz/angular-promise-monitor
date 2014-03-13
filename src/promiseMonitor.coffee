angular.module('promiseMonitor', [])
  .factory('$promiseMonitor', ['$q', ($q) ->
    promises = {}
    monitorDefered = $q.defer()
    notify = (promiseScope='default') ->
      monitorDefered.notify(promises[promiseScope].length)
    {
      regiesterPromise: (p, promiseScope='default') ->
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
  .directive('promiseMonitorEnabled', ['$promiseMonitor', ($promiseMonitor) ->
    {
      restrict: 'A',
      link: (scope, elem, attrs) ->
        promiseScope = if attrs.promiseMonitorScope?
          attrs.promiseMonitorScope
        else 'default'
        $promiseMonitor.promise(promiseMonitorScope).then(null, null, (outstandingCount) ->
          if outstandingCount
            attrs.disabled = true
          else
            attrs.disabled = false
        )


    }
  ])
  .directive('promiseMonitorStatus', ['$promiseMonitor', ($promiseMonitor) ->
    {
      restrict: 'A',
      link: (scope, elem, attrs) ->
        promiseScope = if attrs.promiseMonitorScope?
          attrs.promiseMonitorScope
        else 'default'
        $promiseMonitor.promise(promiseScope).then(null, null, (outstandingCount)->
         if outstandingCount
          elem.html "#{outstandingCount} jobs pending"
         else
           elem.html ''
        )

    }
  ])
