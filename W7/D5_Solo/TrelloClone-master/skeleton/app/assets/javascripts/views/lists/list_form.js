TrelloClone.Views.ListForm = Backbone.View.extend({
  template: JST['lists/form'],

  events: {
    "click .add-list": "showForm",
    "click .btn-success": "createList",
    "click .cancel": "hideForm"
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);

    return this;
  },

  showForm: function(event){
    event.preventDefault();
    $("form").css("display", "inline");
    $(".add-list").css("display", "none");
    $("form textarea").focus();
  },

  createList: function(event){
    if(this.$("textarea").val() !== ""){
      this.collection.create({
        title: this.$("textarea").val(),
        board_id: this.collection.board.id
      }, { wait: true });
      this.$("textarea").val("");
      $(".list-add-form").css("display", "none");
      $(".add-list").css("display", "inline");
    }
  },

  hideForm: function(event){
    event.preventDefault();
    $(".list-add-form").css("display", "none");
    $(".add-list").css("display", "inline");
  }
});
