angular.module('app').controller('OrganisationShowCtrl', ['$q','$scope', 'getParams', 'userData', '$window', '$http', '$location', '$upload', 'fileReader', '$rootScope', function($q, $scope, getParams, userData, $window, $http, $location, $upload, fileReader, $rootScope) {


  $scope.orgId = getParams.organisationId;

  var getOrganisationProperties = function(){ $scope.organisation = userData.properties };


  deferred = $q.defer();
  deferred.promise.then(getOrganisationProperties);
  userData.get(deferred, true);


  $scope.editable = false;

  $scope.updateProfile = function(property, value) {
    userData.update(property, value, null, true)
   }


  $scope.fileUrl = '/organisations/' + $scope.orgId

  $scope.submitToThis = function(opportunityId) {
    $scope.showForm = true
    $scope.url = "/organisations/" + $scope.orgId + "/opportunities/" + opportunityId + "/submissions/new"
  }



}])