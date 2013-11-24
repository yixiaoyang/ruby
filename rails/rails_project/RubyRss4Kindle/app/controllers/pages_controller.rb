class PagesController < ApplicationController
  protect_from_forgery with: :exception
  include SessionsHelper
  

  def about
    @title="About"
  end

  def home
    if signed_in?
      @title="#{current_user.name}'s 'Home"
    else
      # 如果提交失败，首页还会需要一一些的实例变量
      @title="Home"
      render 'pages/home'
    end
  end

  def contact
    @title="Contact"
  end  

end
