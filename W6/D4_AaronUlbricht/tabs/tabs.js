$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data('content-tabs'));
  this.$activeTab = $('.tabs .active');
  this.$el.on('click', 'a', this.clickTab.bind(this));
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};

$.Tabs.prototype.clickTab = function(event) {
  event.preventDefault();
  var $currentTarget = $(event.currentTarget);

  var $currentPane = $('#content-tabs .active');
  $currentPane.removeClass('active');
  $currentPane.addClass('transitioning');

  this.$activeTab.removeClass('active');
  this.$activeTab = $currentTarget;

  $currentPane.on('transitionend', this.onTransition.bind(this));
}

$.Tabs.prototype.onTransition = function (event) {
  $(event.currentTarget).removeClass('transitioning');
  this.$activeTab.addClass('active');

  var pane = this.$activeTab.attr('href');
  $(pane).addClass('active');
  $(pane).addClass('transitioning');

  setTimeout(function(){
    $(pane).removeClass('transitioning');
  }, 0)
};
