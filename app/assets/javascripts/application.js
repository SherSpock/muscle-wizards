// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/datepicker
//= require foundation
//= require magnific-popup
//= require highcharts
//= require chartkick
//= require_tree .


$(function(){
  $(document).foundation();
  $('.close').click(function(){
    $('.alert-box').hide();
  });
  $('.image-container').magnificPopup({
    type:'image',
    delegate: 'a',
    image: {
      titleSrc: function(item) {
        return item.el.attr('title');
      }
    },
    gallery: {enabled:true}
  });
  $(function() {
    $('#contest_date').datepicker({
      dateFormat: 'yy-mm-dd'
    });
  });
  $(function() {
    $('#certification_date_granted').datepicker({
      dateFormat: 'yy-mm-dd'
    });
  });
  $(function() {
    $('#prep_contests_attributes_0_date').datepicker({
      dateFormat: 'yy-mm-dd'
    });
  });
  $('.highcharts-container').find('svg').attr('style', 'font-family: "Work Sans"');
  $('.highcharts-axis').find('text').attr('style', 'color:#ffffff;fill:#ffffff' );
  $('.highcharts-axis-labels').find('text').attr('style', 'color:#ffffff;fill:#ffffff');
  $('.alert-box').delay(3000).fadeOut(1000);
  convert_to_local_time();
});

function convert_to_local_time() {
  $('.message-time').each(function() {
    var el = $(this);
    var utc_time = el.html();
    var local_time = new Date(utc_time);
    el.html(local_time.toLocaleString());
  });
}
