TrelloClone.Views.CardShow = Backbone.CompositeView.extend({
  template: JST["cards/show"],

  events: {
    "click li": "showModal",
    "click button.glyphicon-remove": "delete"
  },

  render: function(){
    var content = this.template({
      card: this.model
    });

    this.$el.html(content);
    return this;
  },

  delete: function(){
    var id = this.model.id;
    
  }
});
