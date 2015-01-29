Journal.Views.PostsIndex = Backbone.View.extend({
  template: JST['index'],
  tagName: 'ul',
  className: 'posts-index',
  initialize: function () {
    this.listenTo(this.collection, "remove sync", this.render)
  },

  render: function () {
    this.$el.empty();
    var content = this.template();
    this.$el.html(content);

    var that = this;
    this.collection.each(function (post) {
      var view = new Journal.Views.IndexItemShow({ model: post });
      that.$el.append( (view.render()).$el );
    });

    return this;
  }
});
