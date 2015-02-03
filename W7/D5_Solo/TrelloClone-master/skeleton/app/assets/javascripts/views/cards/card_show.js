TrelloClone.Views.CardShow = Backbone.CompositeView.extend({
  template: JST["cards/show"],
  tagName: "li",
  className: "card-item",

  events: {
    "click button.glyphicon-remove": "delete",
    "click .card-add-btn": "addCard"
  },

  initialize: function(){
    this.listenTo(this.model, "sync", this.render);
  },

  render: function(){
    var content = this.template({
      card: this.model
    });

    this.$el.html(content);
    return this;
  },

  delete: function(){
    this.model.destroy();
  },

  addCard: function(){

  }
});
