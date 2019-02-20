$(document).on('turbolinks:load', function() {
  var component = $('.admin-dashboards-index-page');
  if (component.length > 0) {
    component.find('.echart').each(function(){
      $(this).css({ 'width': $(this).width(), 'height': $(this).width()/2 })
      echarts.init($(this)[0]).setOption($(this).data('chart-data'));
    });
  }
});
