class PagesController < ApplicationController
  # 添加session相关资源module
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def about
    @title="About"
  end

  def home
    if signed_in?
     @title="#{current_user.name}'s 'Home"
     @micropost = current_user.microposts.build
     @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
      
     if @user.nil?
      @user = current_user
     end
    else
     # 如果提交失败，首页还会需要一一些的实例变量
     @title="Home"
     @feed_items = []
     if @user.nil?
      @user = current_user
     end
     render 'pages/home'
    end
   
  end

  def contact
    @title="Contact"
  end  

end
