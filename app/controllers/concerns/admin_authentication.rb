# frozen_string_literal: true

module AdminAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :ensure_authenticated_admin
  end

  private

  def ensure_authenticated_admin
    return if authenticate_admin(session[:admin_id])

    flash[:warning] = '操作之前请先登录'
    redirect_to admin_login_url
  end

  def authenticate_admin(admin_id)
    return unless (authenticated_admin = Admin.find_by(id: admin_id))

    session[:admin_id] = authenticated_admin.id
    @current_admin = authenticated_admin
  end

  def unauthenticate_admin
    @current_admin = nil
    session[:admin_id] = nil
  end

  def current_admin
    @current_admin
  end
end
