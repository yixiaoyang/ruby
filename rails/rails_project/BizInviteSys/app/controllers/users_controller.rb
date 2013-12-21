class UsersController < ApplicationController
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper
 
  # 登录检测的先前过滤器
  before_action :signed_in_check, only:[:edit, :update, :show, :index, :destroy]
  # 检测权限的先前过滤器
  before_action :correct_user_check,  only:[:edit, :update, :show]
  # 删除前确认是管理员
  before_action :admin_user_check, only: [:destroy, :index]
  
  def new
    @user = User.new
  end
  
  def show
    if @user.nil?
      begin
        @user = User.find(user_params)
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "User id #{params[:id]} not found"
        redirect_to not_found_url
      else
      end
    end
    
    @profile = @user.profile
  end
  
  
  ###
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Creat Account Success,Welcome #{@user[:name]}!"
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    p "edit controller"
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
    user = User.find(user_params)
    user.destroy
    flash[:success] = "User destroyed"
    redirect_to users_url
  end

  def forgot_passwd
  end
  
  def email_notify
    if current_user.nil?
      email = user_params[:email] unless user_params.nil?
      if email.nil? or email.length==0
        @error = "Set you email please"
      else
        begin
          users = User.where("email = ?", email).limit(1)
          if users.nil? or users.size == 0
            @error = "User email #{email} not found"
          end
        rescue ActiveRecord::RecordNotFound
          @error = "User email #{email} not found"
        end
      end
      
      if @error.nil?
        # send mail
        Notifier.email_user(users[0])
        flash[:success] = "Password sent to your email #{email}, please check your mailbox"
        p "send email ok"
        redirect_to signin_path
      else
        flash[:error] = @error
        redirect_to forgot_passwd_path
      end
    end

  end
  
  
  private
  # 使用健壮参数而非User.find_by(params[:id]);
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
