var readline = require("readline");

var reader = readline.createInterface( process.stdin,
  process.stdout,
  null);

  function TowersOfHanoi() {
    this.stacks = this.createBoard();
  }

  TowersOfHanoi.prototype.getBoardSize = function() {
    var size = 0;
    for(var i = 0; i < this.stacks.length; i++) {
      size += stacks[i].length;
    }

    return size;
  }

  TowersOfHanoi.prototype.createBoard = function() {
    arr = [];

    for (var i = 0; i < 3; i++) {
      arr.push([]);
    }

    return arr;
  }

  TowersOfHanoi.prototype.getSizeFromUser = function (callback) {
    var that = this;


  }

  TowersOfHanoi.prototype.isWon = function() {
    console.log(this.boardSize);
    console.log(this.stacks[0].length)
    console.log(this.stacks[2].length);
    console.log(this.stacks[1].length);
    if((this.stacks[2].length == this.boardSize) || (this.stacks[1].length == this.boardSize)) {
      return true;
    } else {
      return false;
    }
  }

  TowersOfHanoi.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
    if (this.stacks[startTowerIdx].length !== 0) {
      if (this.stacks[endTowerIdx].length == 0) {
        return true;
      } else if (this.stacks[endTowerIdx][-1] > this.stacks[startTowerIdx][-1]) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  TowersOfHanoi.prototype.move = function (startTowerIdx, endTowerIdx) {
    try {
      if (!this.isValidMove(startTowerIdx, endTowerIdx)) {
        throw "This is not a valid move!";
      } else {
        this.stacks[endTowerIdx].push(this.stacks[startTowerIdx].pop());
      }
    } catch(err) {
      console.log(err);
    }
  }

  TowersOfHanoi.prototype.print = function () {
    JSON.stringify(this.stacks);
  }



  TowersOfHanoi.prototype.run = function(completionCallback) {

    var that = this;

    reader.question("How many pieces do you want to play with?", function(size){
      for(var i = parseInt(size); i > 0; i--) {
        that.stacks[0].push(i);
      }
      console.log(that);

      TowersOfHanoi.prototype.promptMove = function(callback) {
        this.print;
        reader.question("Where do you want to move from?", function(startIdx) {
          reader.question("Where do you want to move to?", function(endIdx) {
            console.log(that.isWon());
            if(!that.isWon()) {
              that.move(startIdx, endIdx);
              console.log(startIdx);
              console.log(endIdx);
            }
          });
        });
      }
      that.promptMove();
    });
  }

    toh = new TowersOfHanoi();
    toh.run();
