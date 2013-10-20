class UsersController < ApplicationController
  def new
  end
  
  def show
    # 我们使用 params 获取用户的 id。当我们向 Users 控制器发送请求时，params[:id] 
    # 会返回用户的 id，即 1，所以这和直接调用 User.find(1) 的效果一样。（严格来说，
    # params[:id] 返回的是字符串 "1"，find 方法会自动将其转换成整数形式
    @user = User.find_by(params[:id]);
  end
end
