$(function () {
  $(document).on('click', '.smooth-scroll', function (e) {
    e.preventDefault();
    var targetSelector = $(this).attr('href');
    var $target = $(targetSelector);
    $('html,body').animate({
      scrollTop: $target.offset().top
    }, 1000);
  });
});

