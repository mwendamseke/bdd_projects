angular.module('app').factory('userData', ['$http', 'getParams', function($http, getParams){
	
	userData = {}

	userData.properties = {};

	userData.get = function(deferred, isOrganisation){
		url = (isOrganisation) ? '/organisations/' : '/users/'
		id = (isOrganisation) ? getParams.organisationId : getParams.userId
		$http.get(url + id + '.json').success(function(data){
			userData.properties = data;
			if (deferred) { 
				deferred.resolve() 
			}
	});


	userData.update = function(property, value, collectionId, isOrganisation) {
		url = (isOrganisation) ? '/organisations/' : '/users/'
		id = (isOrganisation) ? getParams.organisationId : getParams.userId
		var data = {}
		data[property] = value
		!collectionId ? $http.put(url + id, data) : $http.put(url + id + '/collections/' + collectionId, data);
		}
	};

	userData.sendSelection = function(id) {
		var data = {};
		data["workSelection"] = [];
		data["workSelection"].push(id);
		$http.put('/users/' + getParams.userId + '.json', data);
	}

	return userData

}]);