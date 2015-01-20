(function(){

  var Asteroids = window.Asteroids = window.Asteroids || {};
  var Util = Asteroids.Util = Asteroids.Util || {};

  Asteroids.Util.inherits = function(ChildClass, ParentClass){
  function Surrogate(){};
  Surrogate.prototype = ParentClass.prototype;
  ChildClass.prototype = new Surrogate();
  };

  Asteroids.Util.randomVec = function() {
    var max = 5;
    var min = -5;
    var x = Math.floor(Math.random() * (max - min)) + min;
    var y = Math.floor(Math.random() * (max - min)) + min;
    return [x, y];
  };

})();
