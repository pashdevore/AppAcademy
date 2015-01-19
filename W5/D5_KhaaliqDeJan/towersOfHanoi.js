function TowersOfHanoi() {
  this.towers = [[3,2,1], [], []];
}

TowersOfHanoi.prototype.isWon = function() {
  if(this.towers[1].length == 3 || this.towers[2].length === 3) {
    return true;
  } else {
    return false;
  }
};

TowersOfHanoi.prototype.print = function () {
  console.log(JSON.stringify(this.towers));
};

TowersOfHanoi.prototype.isValidMove = function(startTowerIdx, endTowerIdx) {
  var startTower = this.towers[startTowerIdx];
  var endTower = this.towers[endTowerIdx];
  console.log(startTower[startTower.length - 1]);
  console.log(endTower[endTower.length - 1]);

  if(startTower.length === 0) {
    return false;
  } else if(endTower.length === 0) {
    return true;
  } else {
    return startTower[startTower.length - 1] < endTower[endTower.length - 1];
  }
};

TowersOfHanoi.prototype.move = function(startTowerIdx, endTowerIdx) {
  if(this.isValidMove(startTowerIdx, endTowerIdx)) {
    this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());
    // return true;
  }
};

TowersOfHanoi.prototype.promptMove = function(reader, callback) {
  this.print();
  reader.question("Where would you like to move from?", function(start) {
    var startTowerIdx = parseInt(start);
    reader.question("Where would you like to move to?", function(end) {
      var endTowerIdx = parseInt(end);
      callback(startTowerIdx, endTowerIdx);
    });
  });
};

TowersOfHanoi.prototype.run = function(reader, completionCallback) {
  this.promptMove(reader, (function (startTowerIdx, endTowerIdx) {
    this.move(startTowerIdx, endTowerIdx);

    if (!this.isWon()) {
      this.run(reader, completionCallback);
    } else {
      this.print();
      console.log("You win!");
      completionCallback();
    }
  }).bind(this));
};

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var toh = new TowersOfHanoi();
toh.run(reader, function(){
  reader.close();
});
