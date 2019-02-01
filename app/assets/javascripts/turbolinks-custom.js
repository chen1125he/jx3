(function() {
  if (App.turbolinksCustomJsInited) { return; }
  App.turbolinksCustomJsInited = true;

  //
  Turbolinks.reload = function() {
    Turbolinks.visit(window.location.href);
  }

  // https://github.com/turbolinks/turbolinks/issues/146
  var dispatchUnloadEvent = function() {
    var event = document.createEvent('Events')
    event.initEvent('turbolinks:unload', true, false)
    document.dispatchEvent(event)
  }
  addEventListener('beforeunload', dispatchUnloadEvent)
  addEventListener('turbolinks:before-render', dispatchUnloadEvent)

  // https://stackoverflow.com/questions/37358652/how-to-refresh-a-page-with-turbolinks
  var scrollPageIdentifier = null;  // 前页
  var scrollPosition = null;        // 前页的位置信息
  $(document).on('turbolinks:load', function() {
    var currentScrollPageIdentifier = $('meta[name="turbolinks-scrollable"]').attr('content');
    if (currentScrollPageIdentifier && currentScrollPageIdentifier === scrollPageIdentifier && scrollPosition) {
      window.scrollTo.apply(window, scrollPosition);
    }

    scrollPageIdentifier = currentScrollPageIdentifier;
    scrollPosition = null;
  });

  $(document).on('turbolinks:unload', function() {
    scrollPosition = [window.scrollX, window.scrollY];
  });

  // turbolinks-anchor-smooth
  $(document).on('turbolinks:load', function() {
    $('a[href*="#"]:not([href="#"])').click(function(event) {
      if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
        if (target.length) {
          $('html, body').animate({
            scrollTop: target.offset().top
          }, 1000);
          event.preventDefault();
        }
      }
    });
  });
}).call(this);
