class ChannelsController < ApplicationController
  # 添加session相关资源module
  protect_from_forgery with: :exception
  include SessionsHelper
  
  
  
  # 登录检测的先前过滤器
  before_action :signed_in_check, only:[:edit, :update, :show, :index, :destroy]
  # 检测权限的先前过滤器
  # before_action :correct_user_check,  only:[:edit, :update]
  # 删除前确认是管理员
  before_action :admin_user_check, only: :destroy
  
  def new
    @channel = Channel.new
  end
  
  def create
    @channel = current_user.channels.build(channel_params)
    
    # update empty filed..
    if @channel.title.nil?
    @channel.title = "Channel#{Channel.all.count}" 
    end
    if @channel.description.nil?
      @channel.description = "Description empty"
    end
    
    if @channel.save
      flash[:success] = "Followed"
      redirect_back_or current_user
      else
        flash[:error] = "Followed Failed"
        redirect_back_or current_user
    end
  end
  
  
  private
    def channel_params
      params.require(:channel).permit(:url, :title, :description, :user_id)
    end
    
    def channel_user_check
      begin
      channel = current_user.channels.find_by(:id => params[:id])
      rescue
      flash[:error] = "Not your post, destroy failed"
      redirect_to current_users_path
      end
    end
end