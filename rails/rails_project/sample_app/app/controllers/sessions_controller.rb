class SessionsController < ApplicationController
def new
end

def destroy 
end

def create
  # params表单名:session, has_secure_password 提供的 authenticate 方法
  user = User.find_by(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
    # flash.now[:success] = 'Welcome: '+user.name
    # 登录成功直接定向到用户主界面
    redirect_to user
  else
    # 用 flash.now 替换 flash。flash.now 就是专门用来在重新渲染的页面中显示
    # Flash 消息的，在发送新的请求之后，Flash 消息便会消失
    flash.now[:error] = 'Invalid email:' + params[:session][:email].downcase + ' or password:'+params[:session][:password]
    render 'new'
  end
end

end
