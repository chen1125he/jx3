# frozen_string_literal: true

class Admin::BaseController < ActionController::Base
  layout 'application'
  include RenderingHelper

  def current_service
    @current_service ||= Service.find_by(name: '剑胆琴心')
  end
end
