(function(){
  var Asteroids = window.Asteroids = window.Asteroids || {};



  var Bullet = Asteroids.Bullet = function(pos, game) {
    this.pos = pos;
    this.game = game;
    this.vel = [0, 0];
    this.color = Bullet.COLOR;
    this.radius = Bullet.RADIUS;
  };

  Bullet.COLOR = "#00ff00"
  Bullet.RADIUS = 5;
  Asteroids.Util.inherits(Bullet, Asteroids.MovingObject);

  Bullet.prototype.collideWith = function (asteroid) {
    if(asteroid instanceof Asteroids.Asteroid){
      this.game.remove(this.game.asteroids, asteroid);
      this.game.remove(this.game.bullets, this);
      }
  };


})();
