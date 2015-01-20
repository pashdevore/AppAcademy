Function.prototype.inherits = function(obj) {
  function Surrogate(){};
  Surrogate.prototype = obj.prototype;
  this.prototype = new Surrogate();
};

function MovingObject(){
  this.vel = 0;
}

function Ship(){

};

Ship.inherits(MovingObject);
function Asteroid(){};
Asteroid.inherits(MovingObject);

Ship.prototype.draw = function(){
  console.log("Ships n shit");
};

Asteroid.prototype.draw = function(){
  console.log("fuckin asteroids");
};

MovingObject.prototype.move = function(){ console.log("MOVING!");};
s = new Ship();
a = new Asteroid();

s.move();
a.move();

s.draw();
a.draw();
