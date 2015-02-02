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
    this.renderListForm();
    return this;
  },

  renderLists: function(){
    this.model.lists().each(this.addList.bind(this));
  },

  renderListForm: function(){
    var view = new TrelloClone.Views.ListForm({
      collection: this.collection
    });
    this.addSubview('#list-form', view);
  },

  addList: function(list){
    var view = new TrelloClone.Views.ListShow({
      model: list
    });
    this.addSubview("#lists", view);
  }
});
