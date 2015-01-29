window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new Journal.Router();
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Journal.initialize();
});
