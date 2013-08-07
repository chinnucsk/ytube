function FVideo($scope, $http) {
	$http.get('api/videos/featured_nyt').success(function(data) {
	    $scope.nytFeaturedVideos = data.rows;
    });
    $http.get('api/videos/featured_wsj').success(function(data1) {
	    $scope.wsjFeaturedVideos = data1.rows;
    });
    $http.get('api/videos/featured_cbs').success(function(data2) {
	    $scope.cbsFeaturedVideos = data2.rows;
    });
    $http.get('api/videos/home_video').success(function(dat) {
	    $scope.homeVideoEmbedPath = dat.rows[0].value[2];
	    $scope.homeVideoTitle = dat.rows[0].value[1];
    });
}	

function SVideo($scope, $http){
    $scope.testVal = "Some Testin !!!";
    console.log("Svideo Controller !!");
}