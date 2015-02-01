TrelloClone.Collections.Cards = Backbone.Collection.extend({
  urlRoot: "api/cards",
  model: TrelloClone.Models.Card,
  
  intialize: function(models, options){
    this.list = options.list;
  }
});
