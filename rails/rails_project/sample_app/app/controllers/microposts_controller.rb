class MicropostsController < ApplicationController
  # 添加session相关资源module
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :signed_in_check, only:[:create, :destroy]
  
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
  end
  
  private
    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
