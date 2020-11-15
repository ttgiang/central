var app = angular.module('angularjs-starter', ['ui.bootstrap']);

app.controller('MainCtrl', function($scope) {
  $scope.labels = ['Label1', 'Label2', 'Label3'];
  $scope.label = 'Label';
});