class PagesController < ApplicationController
  # 添加session相关资源module
  protect_from_forgery with: :exception

  def about
    @title="About"
  end

  def home
    @title="Home"
  end

  def contact
    @title="Contact"
  end  

end
