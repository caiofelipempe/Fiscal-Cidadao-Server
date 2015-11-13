(function(){
  'use strict';

  angular
  .module('cidadaoApp', ['ngMaterial', 'ngAnimate'])
  .config(['$mdThemingProvider', function($mdThemingProvider) {

    $mdThemingProvider.theme('default')
      .primaryPalette('blue-grey', {
        'default' : '700',
        'hue-1' : '500'
      })
      .accentPalette('teal', {
        'default' : '600'
      });
  }]);
})();
