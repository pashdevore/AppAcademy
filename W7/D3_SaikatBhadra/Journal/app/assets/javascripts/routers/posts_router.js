Journal.Router = Backbone.Router.extend({
  routes: {
    "": "postsIndex",
    "posts/:id" : "postShow",
    "posts/:id/edit" : "editPost",
  },

  initialize: function() {
    this.collection = new Journal.Collections.Posts();
  },

  postsIndex: function() {
    var that = this;
    this.collection.fetch({
      success: function () {
        var index = new Journal.Views.PostsIndex({ collection: that.collection });
        $(".content").html(index.render().$el);
      }
    });
  },

  postShow: function(id) {
    var post = this.collection.getOrFetch(id);
    var postView = new Journal.Views.PostShow({ model: post });
    $(".content").html(postView.render().$el);
  },

  editPost: function(id) {
    var post = this.collection.getOrFetch(id);
    var formView = new Journal.Views.PostForm({ model: post });
    $(".content").html(formView.render().$el);
  },
});
