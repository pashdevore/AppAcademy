$.Carousel = function (el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.$items = $('div.items img');
  $('div.items img:first-child').addClass('active');
  this.transitioning = false

  this.$el.children('.slide-left').on("click", this.slide.bind(this, 1));
  this.$el.children('.slide-right').on("click", this.slide.bind(this, -1));
};

$.Carousel.prototype.slide = function(dir) {
  if (this.transitioning){
    return;
  } else {
    this.transitioning = true;
    var length = this.$items.length;

    var oldImg = $(this.$items[this.activeIdx]);
    if (dir === 1) {
      oldImg.addClass('left');
    } else {
      oldImg.addClass('right');
    }

    if (dir === 1) {
      this.activeIdx += 1;
      this.activeIdx = this.activeIdx >= length ? (this.activeIdx - length) : this.activeIdx;
      $(this.$items[this.activeIdx]).addClass('right');
    } else {
      this.activeIdx -= 1
      this.activeIdx = this.activeIdx < 0 ? (this.activeIdx + length) : this.activeIdx;
      $(this.$items[this.activeIdx]).addClass('left');
    }

    var activeImg = $(this.$items[this.activeIdx]).addClass('active');
    setTimeout(function(){
      activeImg.removeClass('left');
      activeImg.removeClass('right');
    }, 0);

    var that = this;
    oldImg.one('transitionend', function(){
      oldImg.removeClass('left');
      oldImg.removeClass('right');
      oldImg.removeClass('active');
      that.transitioning = false;
    });
  }
};

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
