class UsersController < ApplicationController
  # 添加session相关资源module
  protect_from_forgery with: :exception
  include SessionsHelper
  

  # 登录检测的先前过滤器
  before_action :signed_in_check, only:[:edit, :update, :show]
  # 检测权限的先前过滤器
  before_action :correct_user_check,  only:[:edit, :update, :show]

  def new
  @user = User.new
  end
  
  ###  
  def show
    # 用户只能访问自己的user信息, 一种unRuby的实现...
    #if @current_user[:id].to_s != params[:id].to_s
    #  flash[:notice] = "Fobidden access to user #{params[:id]}"
    #  p @current_user
    #  p params
    #  redirect_to @current_user
    #else
    
    # 因为correct_check过滤器中定义了@user，这里不需要重复查询了
    #begin
    #  @user = User.find(params[:id])
    #rescue ActiveRecord::RecordNotFound
    #  flash[:success] = "User id #{params[:id]} not found"
    #  redirect_to signin_url
    #else
    #  # 无异常分支
    #end
    #end
  end


  ###
  def create
    # 我们使用 params 获取用户的 id。当我们向 Users 控制器发送请求时，params[:id] 
    # 会返回用户的 id，即 1，所以这和直接调用 User.find(1) 的效果一样。（严格来说，
    # params[:id] 返回的是字符串 "1"，find 方法会自动将其转换成整数形式
    #@user = User.find_by(user_params);
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Creat Account Success,Welcome #{@user[:name]}!"
      
      # 创建成功，处理session，定向到用户主界面
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    # 因为correct_check过滤器中定义了@user，这里不需要重复查询了
    # @user = User.find_by(params[:id])
  end

  def update
    # 因为correct_check过滤器中定义了@user，这里不需要重复查询了
    # @user = User.find_by(params[:id])
    # 使用安全参数user_params
    if @user.update_attributes(user_params)
      flash[:success] = "profile updated"
      redirect_to @user
    else
      render 'edit'
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
    
    def signed_in_check
      unless signed_in?
        # 记录检查前的页面url，以便在完成登录后跳转
        save_location
        redirect_to signin_url, notice:"Sign in please"    
      end
    end

    def correct_user_check
      @user = User.find_by(params[:id])
      # 使用current_user?方法，its Ruby~
      redirect_to root_path unless current_user?(@user)
    end
end
