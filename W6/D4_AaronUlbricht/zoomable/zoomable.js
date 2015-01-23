$.Zoomable = function (el) {
  this.$el = $(el);
  this.$box = $('.focus-box');

  this.$el.mouseover(this.createBox.bind(this));
};

$.Zoomable.prototype.createBox = function (event) {
  $currentTarget = $(event.currentTarget)
  this.$box.addClass('active');
  this.$el.mousemove(this.moveBox.bind(this));
  this.$el.one("mouseleave", this.removeBox.bind(this));
};

$.Zoomable.prototype.moveBox = function (event) {

  var x = event.pageX;
  var y = event.pageY;
  this.$box.css('left', x)
  this.$box.css('top', y);
};

$.Zoomable.prototype.removeBox = function (event) {
  debugger;
  this.$box.removeClass('active');
};

$.fn.zoomable = function () {
  return this.each(function () {
    new $.Zoomable(this);
  });
};
