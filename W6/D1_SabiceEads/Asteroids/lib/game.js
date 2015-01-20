(function(){
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var Game =  Asteroids.Game = function() {
    this.asteroids = [];
    this.ship = new Asteroids.Ship(this.randomPosition(), this);
    this.addAsteroids();
    this.bullets = [];
  };

  Game.prototype.addAsteroids = function() {
    if(this.asteroids.length < Game.NUM_ASTEROIDS){
      this.asteroids.push(new Asteroids.Asteroid(this.randomPosition(), this));
      this.addAsteroids();
    }
  };

  Game.prototype.randomPosition = function() {
    var x = Math.floor(Math.random() * Game.DIM_X);
    var y = Math.floor(Math.random() * Game.DIM_Y);
    return [x, y];
  };

  Game.prototype.draw = function(ctx){
    c.clearRect(0,0, window.innerWidth,window.innerHeight);
    this.allObjects().forEach(function(obj) {
      obj.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function () {
    this.allObjects().forEach(function(obj){
      obj.move();
    });
  };

  Game.prototype.wrap = function (pos) {
  
    if(pos[0] < 0) {
      pos[0] += window.innerWidth;
    } else if(pos[0] > window.innerWidth) {
      pos[0] -= window.innerWidth;
    }

    if(pos[1] < 0) {
      pos[1] += window.innerHeight;
    } else if(pos[1] > window.innerHeight) {
      pos[1] -= window.innerHeight;
    }

    return pos;
  };

  Game.prototype.checkCollisions = function () {
    var allObjects = this.allObjects();
    for(var i = 0; i < allObjects.length; i++) {
      for(var j = 0; j < allObjects.length; j++) {
        if(allObjects[i].isCollidedWith(allObjects[j]) && j !== i) {
          allObjects[i].collideWith(allObjects[j]);
          allObjects[j].collideWith(allObjects[i]);
        }
      }
    }
  };

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.remove = function (list, obj) {
    var idx = list.indexOf(obj);
    list.splice(idx, 1);
  };

  Game.prototype.allObjects = function () {
    var allObjs = [];

    this.asteroids.forEach(function(asteroid){
      allObjs.push(asteroid);
    });
    allObjs.push(this.ship);
    this.bullets.forEach(function(bullet){
      allObjs.push(bullet);
    });
    return allObjs;
  };


  // Dimensions of the game environment
  Game.DIM_X = window.innerWidth;
  Game.DIM_Y = window.innerHeight;
  Game.NUM_ASTEROIDS = 6;
})();
