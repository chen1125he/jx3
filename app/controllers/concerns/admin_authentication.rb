module AdminAuthentication
  include ActiveSupport::Concern

  included do
    before_action :ensure_authenticated_admin
  end

  private

  def ensure_authenticated_admin
    unless authenticate_admin(session[:admin_id])
      flash[:warning] = '操作之前请先登录'
      redirect_to admin_login_url
    end
  end

  def authenticate_admin(admin_id)
    if authenticated_admin = Admin.find_by(id: admin_id)
      session[:admin_id] = authenticate_admin.id
      @current_admin = authenticate_admin
    end
  end

  def unauthenticate_admin
    @current_admin = nil
    session[:admin_id] = nil
  end

  def current_admin
    @current_admin
  end
end
