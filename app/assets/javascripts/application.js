//= require jquery
//= require jquery.remotipart
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
//= require select2
//= require select2_locale_zh-CN
//= require select2-multiple-custom
//= require echarts.common
//= require clipboard.min
//= require noty
//= require config
//= require metismenu
//= require_tree ./admin


(function() {
  this.App || (this.App = {});

  $(document).on('turbolinks:load', function() {
    App.dateTimePicker.init();

    // Configure noty
    Noty.overrideDefaults({ timeout: 3000, theme: 'bootstrap-v3', closeWith: ['click', 'button'] });

    // Init clipboard
    var btns = new Clipboard('.btn-clipboard[data-clipboard-text]');
    btns.on('success', function(e) {
      var n = new Noty({ text: '复制成功', type: 'success' });
      n.show();
    });
  })
}).call(this);
