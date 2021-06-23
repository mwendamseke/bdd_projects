angular.module('app').controller('CollectionIndexCtrl', ['getParams', '$q', '$scope', 'userData', '$http', '$location', '$upload', 'fileReader', function(getParams, $q, $scope, userData, $http, $location, $upload, fileReader){

  $scope.userId = getParams.userId;

  var getUserData = function(){ $scope.user = userData.properties}

  deferred = $q.defer()
  deferred.promise.then(getUserData)
  userData.get(deferred)

   $scope.updateCollection = function(property, value, collectionId) {
      userData.update(property, value, collectionId)
    }

   $scope.createCollection = function() {
    $http.post('/users/' + $scope.userId +'/collections', {createNewCollection: $scope.userId}).then(function(){
      $http.get('/users/' + $scope.userId + '.json').success(function(data){
        $scope.user = data
      })
    })
   }

   $scope.deleteCollection = function(collectionId){
    $http.delete('/users/' + $scope.userId + '/collections/' + collectionId).then(function(){
      $http.get('/users/' + $scope.userId + '.json').success(function(data){
        $scope.user = data
      })
    })
   };


}])