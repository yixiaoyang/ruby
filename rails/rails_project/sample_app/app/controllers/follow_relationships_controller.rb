class FollowRelationshipsController < ApplicationController
  # 添加session相关资源module
  protect_from_forgery with: :exception
  include SessionsHelper
  
  
  before_action :signed_in_check

  def create
    begin
    user = User.find(params[:follow_relationship][:followed_id])
    current_user.follow!(user) unless user.nil?
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Relationship #{params[:id]} not found"
    else  
    end
    redirect_to users_url
  end

  def destroy
    begin
    user = FollowRelationship.find(params[:id]).followed
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Relationship #{params[:id]} not found"
    else
      current_user.unfollow!(user)  unless user.nil?
    end
    redirect_to users_url
  end
end

