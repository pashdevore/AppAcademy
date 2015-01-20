(function(){
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var MovingObject = Asteroids.MovingObject = function(pos, vel, radius, color) {
    this.pos = pos;
    this.vel = vel;
    this.radius = radius;
    this.color = color;
  };

  MovingObject.prototype.draw = function(ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    // arc(x, y, radius, startAngle, endAngle)
    ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2*Math.PI);
    ctx.fill();
  };

  MovingObject.prototype.move = function(){
   this.pos[0] += this.vel[0];
   this.pos[1] += this.vel[1];

   if(!(this instanceof Asteroids.Bullet)){
     this.game.wrap(this.pos);
   }
  };

  MovingObject.prototype.isCollidedWith = function (otherObject) {
    var distanceBetween = Math.sqrt(Math.pow((this.pos[0] - otherObject.pos[0]),2) + Math.pow((this.pos[1] - otherObject.pos[1]),2))

    if(distanceBetween < (this.radius + otherObject.radius)) {
        return true;
    } else {
      return false;
    }
  };

  MovingObject.prototype.collideWith = function (otherObject) {};

})();
