TrelloClone.Views.ListShow = Backbone.CompositeView.extend({
  template: JST["lists/show"],
  className: "list-header-container",

  intialize: function(){
    this.collection = this.model.cards();
    this.listenTo(this.model, 'sync', this.render);
  },

  events: {
    "click button.card-add-btn": "add"
  },

  attributes: function(){
    return{
      //css properties go here
      "data-list-id": this.model.id,
    };
  },

  render: function(){
    var content = this.template({
      list: this.model
    });

    this.$el.html(content);
    this.renderCards();
    this.setHeight();
    return this;
  },

  renderCards: function(){
    this.model.cards().each(this.addCard.bind(this));
  },

  setHeight: function(){
    this.$el.css("height", this.model.collection.length * 70);
  },

  addCard: function(card){
    var view = new TrelloClone.Views.CardShow({
      model: card
    });
    this.addSubview(".card-container", view);
  },

  add: function(){
    debugger
    var newCard = new TrelloClone.Models.Card({title: "hello", list_id:1, ord: 3, description: "boom"});
    this.addCard(newCard);
    newCard.save();
  }
});
