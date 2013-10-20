class UsersController < ApplicationController
  def new
  @user = User.new
  end
  
  ###  
  def show
    @user = User.find(params[:id])
  end
  
  
  ###
  def create
    # 我们使用 params 获取用户的 id。当我们向 Users 控制器发送请求时，params[:id] 
    # 会返回用户的 id，即 1，所以这和直接调用 User.find(1) 的效果一样。（严格来说，
    # params[:id] 返回的是字符串 "1"，find 方法会自动将其转换成整数形式
    #@user = User.find_by(user_params);
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Creat Account Success!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
    # 使用健壮参数而非User.find_by(params[:id]);
    # 我们需要 params Hash 包含 :user 元素，而且只允许传入 name、email、password 
    # 和 password_confirmation 属性，防止传入的参数篡改其他字段的设置如admin设置
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
