  $.Thumbnails = function(el){
    this.$el = $(el);
    this.gutterIdx = 0;
    this.$images = $('.gutter-images img');
    this.$active = this.$images.first();
    this.activate();
    this.fillGutterImages();
    this.$el.on("mouseenter", ".gutter-images img", this.handleHover.bind(this));
    this.$el.on("click", ".gutter-images img", this.handleClick.bind(this));
    this.$el.on("click", "a.nav", this.handleNav.bind(this));
  };

  $.Thumbnails.prototype.handleHover = function (event) {
    var $img = $(event.currentTarget);
    this.activate($img);
    var that = this;

    $img.one("mouseleave", function(){
      that.activate();
    });
  };

  $.Thumbnails.prototype.handleClick = function(event){
    this.$active = $(event.currentTarget);
    this.activate();
  }

  $.Thumbnails.prototype.handleNav = function (event) {
    event.preventDefault();
    var dir = parseInt($(event.currentTarget).attr("href"));

    this.gutterIdx += dir;
    if(this.gutterIdx < 0) {
      this.gutterIdx = 0;
    } else if(this.gutterIdx > this.$images.length - 5) {
      this.gutterIdx = this.$images.length - 5;
    }

    this.fillGutterImages();
  };

  $.Thumbnails.prototype.fillGutterImages = function() {
    this.$images.remove();
    for(var i = this.gutterIdx; i < this.gutterIdx + 5; i++) {
      $('.gutter-images').append($(this.$images[i]));
    }
  }

  $.fn.thumbnails = function () {
    return this.each(function () {
      new $.Thumbnails(this);
    });
  };

  $.Thumbnails.prototype.activate = function($img) {
    if (typeof $img === 'undefined'){
      $('.active').html(this.$active.clone());
    } else {
      $('.active').html($img.clone());
    }
  };
