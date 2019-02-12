# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def browser
    @browser ||= Browser.new(request.user_agent)
  end
end
