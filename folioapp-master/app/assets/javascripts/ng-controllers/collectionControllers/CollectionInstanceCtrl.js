angular.module('app').controller('CollectionInstanceCtrl', ['$attrs', 'getParams', '$scope', '$http', '$location', 'fileReader', '$upload', function($attrs, getParams, $scope, $http, $location, fileReader, $upload) {

  $scope.userId = getParams.userId

  $attrs.$observe('collectionId', function(value){
    $scope.collectionId = value
    $scope.fileUrl = '/users/' + $scope.userId + '/collections/' + $scope.collectionId + '/'
  })



}])