angular.module('app').directive("ngFileSelect",function(userData, fileReader, $upload, $location){

  return {
    link: function($scope,el){
      
      el.bind("change", function(e){
      
        $scope.file = (e.srcElement || e.target).files[0];
        $scope.getFile = function() {
			$scope.progress = 0;
    		fileReader.readAsDataUrl($scope.file, $scope)
                  .then(function(result) {
                      $scope.imageSrc = result;
                  });
    	};
        $scope.getFile();

        $scope.onFileSelect = function($files) {
        	if ($scope.editable) {
        		for (var i = 0; i < $files.length; i++) {
        			var file = $files[i];
        			$scope.upload = $upload.upload({
         				url: $scope.fileUrl,
          				method: 'PUT',
          				file: file
        			}).then(function(){
        				(/organisations\/(\d+)/.exec($location.absUrl())) ? userData.get(deferred, true) : userData.get(deferred)
        				// userData.get(deferred)
        			})
        		}
        	}
        }

      	})
      
    }
    
  }
    
});