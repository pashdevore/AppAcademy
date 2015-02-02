TrelloClone.Views.CardShow = Backbone.CompositeView.extend({
  template: JST["cards/show"],

  events: {
    "click button.glyphicon-remove": "delete"
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
    debugger
    this.model.destroy({
      success: function(){
        alert('destroyed');
      }
    });
  }
});
