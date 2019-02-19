(function(){
  App.select2MultipleSelector = {
    init: function(){
      this._selector().select2({
        theme: "bootstrap",
        language: "zh-CN",
        formatLoadMore: '加载中...',
        width: '100%',
        placeholder: '请选择物品',
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
              results: $.map(data.materials, function (material) {
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
