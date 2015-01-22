(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $rootEl) {
    this.$game = game;
    this.$el = $rootEl;
  };

  View.prototype.bindEvents = function () {
    var that = this;
    $(".cell").on("click", function(event) {
      if(!that.$game.isOver()) {
        var currentTarget = event.currentTarget;
        var currentTarget = $(currentTarget);
        if(currentTarget.attr('class') === 'cell blank') {
          that.makeMove(currentTarget);
        } else {
          alert("You can't place a mark here!");
        }
      }
    })
  };

  View.prototype.makeMove = function ($square) {
    var square = $square[0];
    var x = parseInt(square.id[0]);
    var y = parseInt(square.id[2]);
    var pos = [x,y];
    $square.removeClass("blank");
    $square.addClass(this.$game.currentPlayer);
    $square.text(this.$game.currentPlayer);
    this.$game.playMove(pos);
    if(this.$game.isOver()) {

      var winner = this.$game.winner();
      if(winner) {
        var $winnerCells = $("." + winner);
        $winnerCells.addClass("winner");

        var $blankCells = $(".blank");
        $blankCells.addClass("done");

        var $winner = $("<h1 class=\"result\">You've won, " + winner + "!</h1>");
        this.$el.append($winner);


      }
      else{
        var $draw = $("<h1 class=\"result\">It's a draw...</h1>");
        this.$el.append($draw);
      }
    }
  };

  View.prototype.setupBoard = function () {
    var $board = $("<div class=\"board\"></div>");

    for (var i = 0; i < 3; i++) {
      var $row = $("<div class=\"row\"></div>");

      for (var j = 0; j < 3; j++) {
        var $cell = $("<div class=\"cell blank\"></div>");
        $cell.attr("id", [i,j]);
        $row.append($cell);
        console.log(j);
        console.log($row);
      }
      $board.append($row);
    }
    this.$el.append($board);
  };
})();
