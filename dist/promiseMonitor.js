// Generated by CoffeeScript 1.7.1
angular.module('promiseMonitor', []).factory('$promiseMonitor', [
  '$q', function($q) {
    var monitorDefered, notify, promises;
    promises = {};
    monitorDefered = $q.defer();
    notify = function(promiseScope) {
      if (promiseScope == null) {
        promiseScope = 'default';
      }
      return monitorDefered.notify(promises[promiseScope].length);
    };
    return {
      registerPromise: function(p, promiseScope) {
        if (promiseScope == null) {
          promiseScope = 'default';
        }
        promises[promiseScope] || (promises[promiseScope] = []);
        promises[promiseScope].push(p);
        notify(promiseScope);
        return promise["finally"](function() {
          promises[promiseScope].splice(promises[promiseScope].indexOf(p), 1);
          return notify(promiseScope);
        });
      },
      pending: function(promiseScope) {
        if (promiseScope == null) {
          promiseScope = 'default';
        }
        return promises[promiseScope].length;
      },
      promise: function() {
        return monitorDefered.promise;
      }
    };
  }
]);
