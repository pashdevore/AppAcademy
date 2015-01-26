$.UsersSearch = function(el) {
  this.$el = $(el);
  this.$userInput = $("div.userssearch input");
  this.ul = $('ul.users');
  this.$userInput.keyup(this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function(event){
  var that = this;

  $.ajax({
    type: "GET",
    url: window.location.origin + "/users/search",
    data: { "query": event.currentTarget.value },
    dataType: "json",
    success: function(resp){
      that.renderResults(resp)
      console.log(resp);
    }
  });
};

$.UsersSearch.prototype.renderResults = function(arr) {
  this.ul.empty();
  for(var i = 0; i < arr.length; i++){
    this.ul.append("<li>" + arr[i].username + "</li>");
    if (arr[i].followed) {
      this.ul.append("<button class='follow-toggle' data-user-id=" + arr[i].id + " data-follow-state='followed'></button>");
    } else {
      this.ul.append("<button class='follow-toggle' data-user-id=" + arr[i].id + " data-follow-state='unfollowed'></button>");
    }

  }
  this.ul.find('.follow-toggle').followToggle();
};

$.fn.usersSearch = function(){
  return this.each(function() {
    new $.UsersSearch(this);
  });
};

$(function () {
  $("div.userssearch").usersSearch();
})
