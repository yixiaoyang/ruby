class UsersController < ApplicationController
  # 添加session相关资源module
  protect_from_forgery with: :exception
  include SessionsHelper
  

  # 登录检测的先前过滤器
  before_action :signed_in_check, only:[:edit, :update, :show, :index, :destroy, :following]
  # 检测权限的先前过滤器
  before_action :correct_user_check,  only:[:edit, :update]
  # 删除前确认是管理员
  before_action :admin_user_check, only: :destroy

  def new
  @user = User.new
  end
  
  ###  
  def show
    if @user.nil?
      # 因为correct_check过滤器中定义了@user，这里不需要重复查询了
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "User id #{params[:id]} not found"
        redirect_to not_found_url
      else
      end
    end
    # @microposts = @user.microposts.paginate(page: params[:page], per_page: 10)
  end


  ###
  def create
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
  end

  def update
    # 使用安全参数user_params
    if @user.update_attributes(user_params)
      flash[:success] = "profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    # params由will_paginate自动生成，默认取回30个条目
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "User destroyed"
    redirect_to users_url
  end
 
  def following
    @title = "My Channels"
    @user = current_user
    @channels = @user.channels
    @channel = @user.channels.build
    
    p @channel
    
    save_location
    render 'show_channels'
  end

  private
    # 使用健壮参数而非User.find_by(params[:id]);
    # 我们需要 params Hash 包含 :user 元素，而且只允许传入 name、email、password 
    # 和 password_confirmation 属性，防止传入的参数篡改其他字段的设置如admin设置
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    def correct_user_check
      # 注意find的用法和find_by的区别
      @user = User.find_by(:id => params[:id])
      redirect_to root_path unless current_user?(@user)
    end
    
    def admin_user_check
       redirect_to root_path unless current_user.admin?
    end
end
