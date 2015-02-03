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

    $(".lists-container").sortable({
      start: function(event, ui){
        var $listItem = ui.item;
        $listItem.css("box-shadow", "1px 4px 4px #222222");
      }.bind(this),
      stop: function(event, ui){
        var $listItem = ui.item;
        $listItem.css("box-shadow", "none");
        var newOrd = $listItem.index();
        var id = $listItem.data("list-id");

        // var newList = new TrelloClone.Models.List({ model: this.model });
        //
        //
        // var lists = this.model.lists();
        // lists.remove(lists.get(id));
        // lists.add(newList);
        // lists.save();

      }.bind(this)
    });
    $(".card-container").sortable({
      connectWith: ".card-container",
      start: function(event, ui){
        var $cardItem = ui.item;
        var currentHeight = this.$el.css("height");
        this.$el.css("height", currentHeight - 30);
        $cardItem.css("box-shadow", "1px 4px 4px #222222");
      }.bind(this),
      stop: function(event, ui){
        var $cardItem = ui.item;
        $cardItem.css("box-shadow", "none");
        var id = $cardItem.data("card-id");
      }.bind(this),
    });
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
    this.addSubview(".lists-container", view);
  },
});
