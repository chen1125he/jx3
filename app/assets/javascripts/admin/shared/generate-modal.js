(function(){
  App.GenerateModal = {
    zipStateTimer: null,

    accessProcessing: function(){
      var that = this;
      var jobPath = that.modal().data('job-path');
      var fn = function() {
        $.get(jobPath, function(data) {
          if (data.status == 'queued' || data.status == 'working') {
            that.zipStateTimer = setTimeout(fn, 1000);
          }

          switch (data.status) {
            case 'queued':
              break;
            case 'working':
              if(data.total && data.at){
                that.modal().find('.processing').removeClass('hidden');
                that.modal().find('span.number.total').text(data.total);
                that.modal().find('span.number.at').text(data.at);
              }
              break;
            case 'complete':
              that.downloadZip(data.payload.filepath);
              $('#modal-window .modal').modal('hide');
              break;
            case 'fail':
              // new Noty({ text: '生成失败，请重试', type: 'error' }).show();
              $('#modal-window .modal').modal('hide');
              alert('生成失败，请重试');
              break;
            case 'interrupted':
              // new Noty({ text: '生成失败，请重试', type: 'error' }).show();
              $('#modal-window .modal').modal('hide');
              alert('生成失败，请重试');
              break;
            default:
              // new Noty({ text: '生成失败，请重试', type: 'error' }).show();
              $('#modal-window .modal').modal('hide');
              alert('生成失败，请重试');
          }
        }).fail(function() {
          // new Noty({ text: '生成失败，请重试', type: 'error' }).show();
          $('#modal-window .modal').modal('hide');
          alert('生成失败，请重试');
        });
      }

      fn();
    },

    downloadZip: function(filepath){
      var downloadLink = this.modal().find('.download-link a');
      var href = downloadLink.data('download-path');
      href = href + '?filepath=' + filepath + '&filename=物品列表.csv';
      downloadLink.attr('href', href);
      downloadLink.trigger('click');
    },

    modal: function(){
      return $('.generate-modal');
    }
  }
}).call(this);
