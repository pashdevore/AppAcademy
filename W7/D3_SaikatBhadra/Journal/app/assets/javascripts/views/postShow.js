Journal.Views.PostShow = Backbone.View.extend({
  events: {
    "click .delete": "removePost"
  },

  initialize: function(){
    this.listenTo(this.model, "sync", this.render)
  },

  template: JST['post_show'],
  tagName: 'li',
  className: 'post',
  render: function () {

    this.$el.empty();
    var content = this.template({model: this.model});
    this.$el.html(content);

    return this;
  },

  removePost: function(){
    this.model.destroy();
  }
});
