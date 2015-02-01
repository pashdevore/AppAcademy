TrelloClone.Models.Board = Backbone.Model.extend({
  urlRoot: "api/boards",

  lists: function(){
    //if no lists attribute is present, create a new lists collection
    if(!this._lists){
      this._lists = new TrelloClone.Collections.Lists([], { board: this });
    }

    return this._lists;
  },

  parse: function (response) {
    if(response.lists) {
      this.lists().set(response.lists, { parse: true });
      delete response.lists;
    }
    
    return response;
  }
});
