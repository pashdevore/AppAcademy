$.FollowToggle = function (el){
  this.$el = $(el);
  this.userId = parseInt(this.$el.attr('data-user-id'));
  this.followState =this.$el.attr('data-follow-state');
  this.$el.on("click", this.handleClick.bind(this));
  this.render();
};

$.fn.followToggle = function(){
  return this.each(function() {
    new $.FollowToggle(this);
  });
};

$.FollowToggle.prototype.render = function() {
  if(this.followState === "following" || this.followState === "unfollowing") {
    this.$el.prop('disabled', true);
  } else if (this.followState === "unfollowed"){
    this.$el.prop('disabled', false);

    this.$el.text("Follow!");
  } else {
    this.$el.prop('disabled', false);
    // $("button.follow-toggle").html('data-follow-state', 'unfollowed');
    this.$el.text("Unfollow!");
  }
};

$.FollowToggle.prototype.handleClick = function(event) {
  event.preventDefault();
  var form = $( this );

  $currentTarget = $(event.currentTarget);
  if (this.followState === "unfollowed") {
    var that = this;

    that.followState = "following";
    that.render();

    $.ajax ({
      type: "POST",
      url: this.userId + "/follow",
      data: form.serialize(),
      dataType: 'json',
      success: function( resp ) {
        that.followState = "followed";
        $currentTarget.attr('data-follow-state', 'followed');
        that.render();
        console.log( resp );
      }
    });
  } else {
    var that = this;

    that.followState = "unfollowing";
    that.render();

    $.ajax ({
      type: "DELETE",
      url: this.userId + "/follow",
      data: form.serialize(),
      dataType: 'json',
      success: function( resp ) {
        that.followState = "unfollowed";
        $currentTarget.attr('data-follow-state', 'unfollowed');
        that.render();
        console.log( resp );
      }
    });
  }

};

$(function () {
  $("button.follow-toggle").followToggle();
})
