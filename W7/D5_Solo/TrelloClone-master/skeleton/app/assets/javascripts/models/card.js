TrelloClone.Models.Card = Backbone.Model.extend({
  url: "api/cards",

  items: function(){
    if(!this._items){
      this._items = new TrelloClone.Collections.Items([], { card: this });
    }

    return this._items;
  },

  parse: function(response){
    if(response.items){
      this._items(response.items, { parse: true });
      delete response.items;
    }

    return response;
  }
});
