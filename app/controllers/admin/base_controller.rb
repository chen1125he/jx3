# frozen_string_literal: true

class Admin::BaseController < ActionController::Base
  layout 'application'
  include RenderingHelper
end
