module UsersHelper
 # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
    # Email MD5加密作为ID
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    
    # 获取全球统一头像
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    
    # 显示头像，返回值是 Gravatar 头像的 img 元素，img 标签的 class 设为 gravatar，
    # alt 属性值是用户的名字（对视觉障碍人士使用的屏幕阅读器很友好）
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
  def correct_user_check
    @user = User.find_by(:id => params[:id])
    if current_user.admin? || current_user?(@user)
    else
      flash[:error] = "Access forbidden operation"
      redirect_to root_path
    end
  end
end
