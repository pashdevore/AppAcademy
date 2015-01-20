(function(){
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var Ship = Asteroids.Ship = function(pos, game) {
    this.vel = [0, 0];
    this.pos = pos;
    this.game = game;
    this.color = Ship.COLOR;
    this.radius = Ship.RADIUS;
    Asteroids.MovingObject.call(this.pos, this.vel, this.radius, this.color, this.game);
  };

  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);

  Ship.prototype.relocate = function (pos) {
    this.pos = pos;
    this.vel = [0,0];
  };

  Ship.RADIUS = 10;
  Ship.COLOR = "#ff0000";

  Ship.prototype.power = function (impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

  Ship.prototype.fireBullet = function () {
    var bulletPos = [this.pos[0]+5, this.pos[1]+5]
    var bullet = new Asteroids.Bullet(bulletPos, this.game);

    if (this.vel[0] < 0) {
      bullet.vel[0] = (this.vel[0] - 10)
    } else {
      bullet.vel[0] = (this.vel[0] + 10)
    }

    if (this.vel[1] < 0) {
      bullet.vel[1] = (this.vel[1] - 10)
    } else {
      bullet.vel[1] = (this.vel[1] + 10)
    }

    this.game.bullets.push(bullet);

  };


})();
