angular.module('app').controller('ProfileCtrl', ['$q','$scope', 'userData' ,'getParams', '$window', '$http', '$location', '$upload','$rootScope', 'fileReader', function($q, $scope, userData, getParams, $window, $http, $location, $upload, $rootScope, fileReader) {


  $scope.user = {
    name: 'Name',
    profession: 'Profession',
    network: 'Network',
    shortBio: 'Short Bio'
  };

  $scope.userId = getParams.userId

  $scope.url = '/users/' + $scope.userId + '/collections';

  var getUserData = function(){ $scope.user = userData.properties}

  deferred = $q.defer()
  deferred.promise.then(getUserData)
  userData.get(deferred)

  $scope.editable = ($window.location.search === "?editable=true") ? true : false


  $scope.updateProfile = function(property, value) {
    userData.update(property, value, null)
  }

  $scope.fileUrl = '/users/' + $scope.userId



}])