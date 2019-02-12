$(document).on('turbolinks:load', function() {
  var component = $('#bulk-import-product-form');

  if (component.length > 0) {
    var fileInput = component.find('#file');
    var submit = component.find('input[type=submit]');

    component.on('change', '#file', function(e){
      file = e.currentTarget.files[0]
      if (file) {
        submit.removeAttr('disabled');
        fileInput.closest('.form-group').find('.custom-file-label').text(file.name);
      } else {
        submit.attr('disabled', true);
        fileInput.closest('.form-group').find('.custom-file-label').text('请选择文件');
      }
    })

    fileInput.trigger('change');
  }
});
