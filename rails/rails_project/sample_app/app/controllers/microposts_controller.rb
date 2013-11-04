class MicropostsController < ApplicationController
  # 添加session相关资源module
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :signed_in_check, only:[:create, :destroy]
  before_action :micropost_user_check, only:[:destroy]
  
  def index
  end
  
  def create
    p params
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Posted"
      redirect_to root_url
    else
      flash[:error] = "Post Failed:content too long"
      @feed_items = []
      redirect_to root_url
    end
  end
  
  def destroy
    micropost = current_user.microposts.find_by(:id => params[:id])
    micropost.destroy
    flash[:success] = "Post destroyed"
    redirect_to current_users_path
  end
  
  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end
    
    def micropost_user_check
      micropost = current_user.microposts.find_by(:id => params[:id])
      if  micropost.nil?
        flash[:error] = "Not your post, destroy failed"
        redirect_to current_users_path
      end
    end
end
