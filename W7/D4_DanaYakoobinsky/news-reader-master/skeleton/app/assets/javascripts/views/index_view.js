NewsReader.Views.IndexView = Backbone.View.extend({
  tagName: "ul",
  template: JST['feed_index'],
  events: {
    "click .delete-feed-btn" : "deleteFeed"
  },

  initialize: function(){
    this.listenTo( this.collection, "sync", this.render );
  },

  render: function(){
    var renderedContent;
    this.$el.empty();
    this.collection.each(function(feed){
      renderedContent = this.template({feed: feed});
      this.$el.append(renderedContent);
    }, this);
    return this;
  },

  deleteFeed: function(event){
    var button = $(event.currentTarget);
    var id = button.data("id");
    var feed = this.collection.get(id);
    feed.destroy();
  }
});
