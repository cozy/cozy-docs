(function() {
  (function($) {
    var $architecture, $counter, $motiv, $navToggle;
    $navToggle = $('.nav-toggle');
    $architecture = $('#architecture');
    $motiv = $('[name=MOTIV]');
    $counter = $motiv.siblings('.notice').find('.counter');
    return $navToggle.on('click', function(event) {
      var $nav;
      event.preventDefault();
      $nav = $navToggle.parents('[aria-expanded]');
      return $nav.attr('aria-expanded', !($nav.attr('aria-expanded') === 'true'));
    });
  })(jQuery);

}).call(this);
