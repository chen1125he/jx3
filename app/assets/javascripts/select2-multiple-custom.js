(function(){
  App.select2MultipleSelector = {
    init: function(){
      this._selector().select2({
        theme: "bootstrap",
        language: "zh-CN",
        formatLoadMore: '加载中...',
        width: '100%',
        placeholder: this._selector().data('placeholder'),
        ajax: {
          url: this._selector().data('path'),
          dataType: "json",
          type: "GET",
          data: function (params) {
            var queryParameters = {
              q: params.term,
              page: params.page
            }
            return queryParameters;
          },
          processResults: function (data, page) {
            return {
              results: $.map(data.items, function (material) {
                return {
                  text: material.name,
                  id: material.id
                }
              }),
              pagination: { more: data.more }
            }
          }
        }
      });
    },

    _selector: function() {
      return $('select.select2-multiple-selector');
    }
  }
}).call(this)
