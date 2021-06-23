angular.module('app').controller('PortfolioSectionCtrl', ['getParams','$scope', '$http', '$location', 'fileReader', '$upload', function(getParams, $scope, $http, $location, fileReader, $upload) {

  $scope.userId = getParams.userId

  $scope.url = '/users/' + $scope.userId + '/collections';

}])