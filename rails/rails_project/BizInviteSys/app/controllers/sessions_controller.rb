class SessionsController < ApplicationController
  # 添加session相关资源module
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def new
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  def create
    # params表单名:session, has_secure_password 提供的 authenticate 方法
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash.now[:success] = 'Welcome: '+user.name
      
      # 处理session，定向到用户主界面
      sign_in user

      # 跳转到登录前的页面
      redirect_back_or user
    else
      # 用 flash.now 替换 flash。flash.now 就是专门用来在重新渲染的页面中显示
      # Flash 消息的，在发送新的请求之后，Flash 消息便会消失
      flash.now[:error] = 'Invalid email:' + params[:session][:email].downcase + ' or password:'+params[:session][:password]
      render 'new'
    end
  end
end
