angular.module('myApp', [])
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
