# frozen_string_literal: true

class Admin::SessionsController < Admin::BaseController
  layout 'login'

  skip_before_action :ensure_authenticated_admin, only: %i[new create]

  def new
  end

  def create
    admin = Admin.find_by(name: params[:name])
    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      @current_admin = admin
      redirect_to admin_root_url
    else
      flash.now[:alert] = '你输入的用户名或者密码错误.'
      render 'new'
    end
  end

  def destroy
    unauthenticate_admin
    redirect_to admin_login_url
  end
end
