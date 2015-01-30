NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: "/api/feeds",
  model: NewsReader.Models.Feed,

  getOrFetch: function(id){
    var feed = this.get(id);
    if(typeof feed === 'undefined'){
      feed = new NewsReader.Models.Feed({id: id});
      var that = this;
      feed.fetch({
        success: function(){
          that.add(feed);
        }
      });
    }

    return feed;
  }
});
