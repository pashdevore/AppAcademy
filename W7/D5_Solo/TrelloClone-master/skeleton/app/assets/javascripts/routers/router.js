TrelloClone.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "index",
    "boards/:id": "show"
  },

  initialize: function(){
    this.$rootEl = $("#main");
  },

  index: function(){
    TrelloClone.Collections.boards.fetch();

    var view = new TrelloClone.Views.BoardsIndex({
      collection: TrelloClone.Collections.boards
    });


    this._swapView(view);
  },

  show: function(id){
    var current = TrelloClone.Collections.boards.getOrFetch(id);

    var view = new TrelloClone.Views.BoardShow({
      model: current
    });

    this._swapView(view);
  },

  _swapView: function(view){
    //if currentView already exists, it is removed
    this.currentView && this.currentView.remove();
    this.currentView = view;

    //we render the view and set it's $el
    //to the current root element in the DOM
    this.$rootEl.html(view.render().$el);
  }
});
