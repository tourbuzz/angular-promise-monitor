angular.module('myApp', [])
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
