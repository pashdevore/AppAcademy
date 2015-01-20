(function(){
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var Asteroid = Asteroids.Asteroid = function(pos, game){
    this.game = game;
    this.pos = pos;
    this.vel = Asteroids.Util.randomVec();
    this.color = Asteroid.COLOR;
    this.radius = Asteroid.RADIUS;

    Asteroids.MovingObject.call(this.pos, this.vel, this.radius, this.color, this.game);
  };

  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);


  Asteroid.prototype.collideWith = function (otherObject) {
    if(otherObject instanceof Asteroids.Ship){
      otherObject.relocate(this.game.randomPosition());
    }
  };

  Asteroid.RADIUS = 20;
  Asteroid.COLOR = "#D3D3D3";



})();
