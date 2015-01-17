Function.prototype.myBind = function (context) {
  fn = this;
  return function () {
    return fn.apply(context);
  };
}

function Snowman(name) {
  this.name = name;
}

var melt = function() {
  console.log(this.name + " is melting :(");
}

Snowman.prototype.sayHi = function() {
  console.log("Hi! I'm " + this.name + " and I like warm hugs.");
}

var olaf = new Snowman("olaf");

setTimeout(melt.myBind(olaf), 2000);
