TrelloClone.Collections.Boards = Backbone.Collection.extend({
  url: "api/boards",
  model: TrelloClone.Models.Board,

  getOrFetch: function(id){
    var board = this.get(id);

    //if the board doesn't exist, create it and fetch
    //otherwise, just fetch it
    if(!board) {
      board = new TrelloClone.Models.Board({ id: id} );
      board.fetch({
        success: function(){
          //don't forget to add the new board
          //to the collection!
          this.add(board);
        }.bind(this)
      });
    } else {
      board.fetch();
    }

    return board;
  }
});

TrelloClone.Collections.boards = new TrelloClone.Collections.Boards();
