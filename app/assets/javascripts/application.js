// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require autocomplete-rails
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap

function startListHeight($tag) {
  
    function setHeight(s) {
        var max = 0;
        s.each(function() {
            var h = $(this).height();
            max = Math.max(max, h);
        }).height('').height(max);
    }
  
    $(window).on('ready load resize', setHeight($tag));
}

jQuery(function($) {
    $('#list_lines').each(function() {
        startListHeight($('.inr_list_lines', this));
    });
});