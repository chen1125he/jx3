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
//= require turbolinks
//= require_self
//= require ./turbolinks-custom
//= require popper
//= require bootstrap
//= require moment
//= require moment/zh-cn
//= require daterangepicker
//= require datetimepicker-custom
//= echarts.simple
//= require config
//= require metismenu
//= require admin/shared/sidebar


(function() {
  this.App || (this.App = {});

  $(document).on('turbolinks:load', function() {
    App.dateTimePicker.init();
  })
}).call(this);
