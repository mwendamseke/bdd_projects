angular.module('app').controller('CollectionShowCtrl', ['$scope', '$q', 'getParams', 'userData', '$http', '$location', function($scope, $q, getParams, userData, $http, $location){

  $scope.userId = getParams.userId;


  var findPortfolioSelection = function(){
    var workIndex;
    if (workIndex = (/#\/(\d+)/.exec($location.absUrl()))) {
      $scope.portfolioSelection = parseInt(workIndex[1], 10);
    }else {
      $scope.portfolioSelection = 0;
    }
  };


  findPortfolioSelection();

  $scope.changePath = function(number){
    $location.path('/' + number)
  };

  $scope.changePath($scope.portfolioSelection)

  $scope.$watch('portfolioSelection', function(){
    $scope.changePath($scope.portfolioSelection)
  })

  var getUserData = function () {
    $scope.user = userData.properties;
    $scope.collection = _.findWhere($scope.user.collections, {id: parseInt(getParams.collectionId)});
  }

  deferred = $q.defer()
  deferred.promise.then(getUserData)
  userData.get(deferred)


  $scope.sendSelection = function(id){ userData.sendSelection(id) };


  $scope.currentWork = function(){
    return $scope.collection.works[$scope.portfolioSelection];
  };

 $scope.displayFull = function(work){
    $scope.portfolioSelection = $scope.collection.works.indexOf(work);
  };

  $scope.togglePortfolio = function(e){
    if (e.keyCode === 39) {
      e.preventDefault();
      if ($scope.portfolioSelection < $scope.collection.works.length - 1) {
        $scope.portfolioSelection += 1
      }
      else {
        return;
      }
    }
    else if (e.keyCode === 37) {
      e.preventDefault();
      if ($scope.portfolioSelection > 0) {
        $scope.portfolioSelection -= 1
      }
      else {
        return;
      }
    }

  };






}])