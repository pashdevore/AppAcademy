TrelloClone.Views.BoardsIndex = Backbone.View.extend({
  template: JST["boards/index"],

  initialize: function(){
    $('body').css('background-color', 'rgb(255, 255, 255)');
    //when a view is initialized, it is passed a collection object
    this.listenTo( this.collection, "sync", this.render);
  },

  render: function(){
    var content = this.template({
      //setting a local variable for the template to access
      boards: this.collection
    });

    this.$el.html(content);
    $(".boards").sortable();
    return this;
  },
});
