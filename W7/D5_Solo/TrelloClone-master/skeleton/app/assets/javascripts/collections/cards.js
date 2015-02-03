TrelloClone.Collections.Cards = Backbone.Collection.extend({
  url: "api/cards",
  model: TrelloClone.Models.Card,
  comparator: "ord",

  intialize: function(models, options){
    this.list = options.list;
  },

  getOrFetch: function(id){
    var card = this.get(id);

    if(!card){
      card = new TrelloClone.Models.Card({ id: id });
      card.fetch({
        success: function(){
          cards.add(card);
        }
      }.bind(this));
    } else {
      card.fetch();
    }

    return card;
  }
});
