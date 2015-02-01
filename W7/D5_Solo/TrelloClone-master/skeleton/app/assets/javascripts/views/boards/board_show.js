TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST["boards/show"],

  initialize: function(){
    $('body').css('background-color', 'rgb(35, 113, 159)');
    this.collection = this.model.lists();
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.addList);
  },

  render: function(){
    var content = this.template({
      board: this.model
    });

    this.$el.html(content);
    this.renderLists();
    return this;
  },

  renderLists: function(){
    this.model.lists().each(this.addList.bind(this));
  },

  addList: function(list){
    var view = new TrelloClone.Views.ListShow({
      model: list
    });
    this.addSubview(".lists-container", view);
  }
});
