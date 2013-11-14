class FollowRelationshipsController < ApplicationController
  # 添加session相关资源module
  protect_from_forgery with: :exception
  include SessionsHelper
 
  before_action :signed_in_check

  def create
    begin
    @user = User.find(params[:follow_relationship][:followed_id])
    current_user.follow!(@user) unless @user.nil?
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Relationship #{params[:id]} not found"
    else 
    end
    
    # ajax surpport
    # 在处理 Ajax 请求时，Rails 会自动调用文件名和动作名一样的“含有 JavaScript 的 
    # ERb（JavaScript Embedded Ruby）”文件（扩展名为 .js.erb），例如 create.js.erb
    # 和 destroy.js.erb
    # 下面代码只有一行会被执行
    respond_to do |format|
      format.html { render 'users' }
      format.js 
    end
    # redirect_to users_url
  end

  def destroy
    begin
    @user = FollowRelationship.find(params[:id]).followed
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Relationship #{params[:id]} not found"
    else
      current_user.unfollow!(@user)  unless @user.nil?
    end
 
    # ajax surpport
    respond_to do |format|
      format.html {  render 'users' }
      format.js 
    end
    # redirect_to users_url
  end
end

