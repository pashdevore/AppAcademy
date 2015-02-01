TrelloClone.Views.ListShow = Backbone.CompositeView.extend({
  template: JST["lists/show"],

  intialize: function(){
    this.collection = this.model.cards();
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function(){
    var content = this.template({
      list: this.model
    });

    this.$el.html(content);
    this.renderCards();
    return this;
  },

  renderCards: function(){
    this.model.cards().each(this.addCard.bind(this));
  },

  addCard: function(card){
    var view = new TrelloClone.Views.CardShow({
      model: card
    });
    this.addSubview(".card-container ul", view);
  }
});
