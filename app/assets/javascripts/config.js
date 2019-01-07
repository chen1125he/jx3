var config, $ref;

$(document).on('turbolinks:load', function() {
  config = window.config = {};

  // Config reference element
  $ref = $("#ref");

  // Configure responsive bootstrap toolkit
  config.ResponsiveBootstrapToolkitVisibilityDivs = {
      'xs': $('<div class="device-xs 				  hidden-sm-up"></div>'),
      'sm': $('<div class="device-sm hidden-xs-down hidden-md-up"></div>'),
      'md': $('<div class="device-md hidden-sm-down hidden-lg-up"></div>'),
      'lg': $('<div class="device-lg hidden-md-down hidden-xl-up"></div>'),
      'xl': $('<div class="device-xl hidden-lg-down			  "></div>'),
  };

  // ResponsiveBootstrapToolkit.use('Custom', config.ResponsiveBootstrapToolkitVisibilityDivs);

  //validation configuration
  config.validations = {
    debug: true,
    errorClass:'has-error',
    validClass:'success',
    errorElement:"span",

    // add error class
    highlight: function(element, errorClass, validClass) {
      $(element).parents("div.form-group")
      .addClass(errorClass)
      .removeClass(validClass);
    },

    // add error class
    unhighlight: function(element, errorClass, validClass) {
      $(element).parents(".has-error")
      .removeClass(errorClass)
      .addClass(validClass);
    },

    // submit handler
      submitHandler: function(form) {
          form.submit();
      }
  }

  //delay time configuration
  config.delayTime = 50;

  // chart configurations
  config.chart = {};

})
