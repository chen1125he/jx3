(function(){
  App.ImportModal = {
    importStateTimer: null,

    accessProcessing: function(){
      var that = this;
      var jobPath = that.modal().data('job-path');
      var successPath = that.modal().data('success-path');
      var fn = function() {
        $.get(jobPath, function(data) {
          if (data.status == 'queued' || data.status == 'working') {
            that.importStateTimer = setTimeout(fn, 1000);
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
              console.log($('#modal-window .modal').modal('hide'));
              if (data.payload.errors.length > 0) {
                that.displayErrors(data.payload.errors);
              } else {
                Turbolinks.visit(successPath);
              }
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

    displayErrors: function(errors){
      var errorLine = null;
      this.errorsCard().removeClass('hidden');
      var errorTbody = this.errorsCard().find('tbody').html('');
      errors.forEach(function(error){
        errorLine = $('<tr>');
        if (error.line) {
          errorLine.append('<td>' + error.line + '</td>');
          errorLine.append('<td>' + error.attribute + '</td>');
          errorLine.append('<td>' + error.message + '</td>');
        } else {
          errorLine.append('<td colspan=\'3\'>' + error.message + '</td>');
        }
        errorTbody.append(errorLine);
      });
    },

    modal: function(){
      return $('.import-modal');
    },

    errorsCard: function(){
      return $('.import-errors.card');
    }
  }
}).call(this);
