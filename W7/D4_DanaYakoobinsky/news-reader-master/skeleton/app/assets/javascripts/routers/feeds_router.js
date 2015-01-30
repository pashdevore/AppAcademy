NewsReader.Routers.FeedsRouter = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.collection = new NewsReader.Collections.Feeds();
    this.feedIndex();
  },

  routes: {
    "" : "feedIndex",
    "feeds/:id": "feedShow"
  },

  feedIndex: function(){
    var feeds = this.collection;
    var indexView = new NewsReader.Views.IndexView({collection: feeds});
    this.$rootEl.find('.feeds-column').html(indexView.$el);

    feeds.fetch();
  },

  feedShow: function(id){
    var feed = this.collection.getOrFetch(id);
    var showView = new NewsReader.Views.FeedShow({model: feed});
    feed.set({id: id});
    feed.fetch({
      success: function(){
      }
    });
    this.$rootEl.find('.feed-show').html(showView.$el);
  },

  _swapView: function(view){
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.find('.feed-show').html(view.$el);
  }
})
