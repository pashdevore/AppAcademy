Journal.Views.PostForm = Backbone.View.extend({
  events: {
    "click button.submit": "submitPost"
  },

  template: JST['post_form'],
  render: function () {
    var content = this.template({post: this.model});
    this.$el.html(content);

    return this;
  },

  submitPost: function(event){

    event.preventDefault();
    var data = this.$el.find("form").serializeJSON();
    this.model.save(data["post"], {
      success: function() {
        Backbone.history.navigate("/#/", { trigger: true });
      },
      error: function(model, response, options){
        debugger;
      },
    });
  }

});
