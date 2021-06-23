angular.module('app').factory('getParams', ['$location', function($location){
	
	var getCollectionId = function() {
		return (/collections\/(\d+)/.exec($location.absUrl())) ? (/collections\/(\d+)/.exec($location.absUrl())[1]) : null
	}

	var getUserId = function() {
		return (/users\/(\d+)/.exec($location.absUrl())) ? (/users\/(\d+)/.exec($location.absUrl())[1]) : null
	}

	var getOrganisationId = function() {
		return (/organisations\/(\d+)/.exec($location.absUrl())) ? (/organisations\/(\d+)/.exec($location.absUrl())[1]) : null
	}

	getParams = {}

	getParams.userId = getUserId();
	getParams.collectionId = getCollectionId();
	getParams.organisationId = getOrganisationId();

	return getParams

}]);

