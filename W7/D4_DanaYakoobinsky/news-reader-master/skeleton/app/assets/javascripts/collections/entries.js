NewsReader.Collections.Entries = Backbone.Collection.extend({
  url: function(){return this.feed.url() + "/entries"},
  model: NewsReader.Models.Entry,
  comparator: function (entry){
    return entry.get('published_at');
  },

  initialize: function(options){
    this.feed = options.feed;
  }
});
