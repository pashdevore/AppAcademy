(function(){
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var GameView = Asteroids.GameView = function(canvasEl){
    this.game = new Asteroids.Game();
    this.ctx = canvasEl.getContext('2d');
  };

  GameView.prototype.bindKeyHandlers = function () {
    key('a', function(){ this.game.ship.power([-.25,0])}.bind(this));
    key('w', function(){ this.game.ship.power([0,-.25])}.bind(this));
    key('s', function(){ this.game.ship.power([0,.25])}.bind(this));
    key('d', function(){ this.game.ship.power([.25,0])}.bind(this));
    key('space', function(){ this.game.ship.fireBullet()}.bind(this));
  };


  GameView.prototype.start = function () {
    this.bindKeyHandlers();

    setInterval((function(){
      this.game.step();
      this.game.draw(this.ctx)}).bind(this) , 20);
  };



})();
