NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feed_show'],
  events: {
    "click button.refresh-btn": "reload"
  },

  initialize: function(){
    this.listenTo(this.model, "sync", this.render);
  },

  render: function(){
    var content = this.template({entries: this.model.entries()});
    this.$el.html(content);
    return this;
  },

  reload: function(){
    var that = this;
    this.model.fetch({
      success: function(){
        that.render();
      }
    });
  }
});
