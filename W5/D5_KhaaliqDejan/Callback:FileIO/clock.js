function Clock () {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  var hr = this.currentTime.getHours();
  var min = this.currentTime.getMinutes();
  var sec = this.currentTime.getSeconds();
  console.log(hr + ":" + min + ":" + sec);
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
  this.currentTime = new Date();
  this.printTime();
  setInterval(clock._tick.bind(clock), Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  this.currentTime.setTime(Date.now());
  this.printTime();
};

var clock = new Clock();
clock.run();
