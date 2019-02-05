(function(){
  App.dateTimePicker = {
    init: function(){
      this._picker().daterangepicker({
        locale: { format: 'YYYY-MM-DD', cancelLabel: '取消', applyLabel: '确定' },
        maxDate: new Date(),
        autoApply: true,
        singleDatePicker: true,
        timePicker: false,
        timePicker24Hour: true,
        drops: 'up'
      });
    },

    _picker: function() {
      return $('input.datetimepicker');
    }
  }
}).call(this)
