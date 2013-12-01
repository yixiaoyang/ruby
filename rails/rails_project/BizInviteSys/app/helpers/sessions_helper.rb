=begin
  如果要自动登入用户，就可以从 cookie 中取出token，加密后查询数据库。
  数据库之所以只保存加密后的token是因为，即便整个数据库都泄露了，攻击者
  也无法使用token登入网站。为了让token更安全，我们计划每次会话都生成不
  一样的token，这样即使会话被劫持了（攻击者偷取 cookie 伪装成某个用户
  登录），用户下次登录时前一个会话就会失效。
=end
module SessionsHelper 
  def sign_in(user)
    remember_token = User.new_remember_token
    
    # 将token（base64生成随机串）存入cookie，保证每次获取的token值不相同
    # 因为开发者经常要把 cookie 的失效日期设为 20 年后，所以 Rails 特别提供了 permanent 方法
    # 等效于 ：
    #   cookies[:remember_token] = { value:   remember_token,expires: 20.years.from_now.utc }
    cookies.permanent[:remember_token] = remember_token
    
    #
    # 将sha1加密的token存入数据库，即使黑客获取了浏览器cookie，也无法获取当前
    # Active Record提供update_attribute()方法可以将Model对象的某个属性保存到数据库。
    # 
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    
    puts "#{user.name} signed in as current user"
    self.current_user = user
  end
  
  
  def current_user=(user)
    @current_user = user
  end

  def current_user
    # 获取加密后的token，查询数据库索引获取对应用户
    remember_token = User.encrypt(cookies[:remember_token])
    
    # 语法：||=（“or equals”）操作符
    # 在第一次调用 current_user 方法时调用 find_by 方法，如果后续再调用的话就
    # 直接返回 @current_user 的值，而不必再查询数据库
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def current_user?(user)
    current_user == user
  end

  def save_location
    # request 对象的 fullpath 方法获取了所请求页面的完整地址 
    # 使用rails的session管理，仅在get方法中使用，保证提交表单时(post)不会存储转向地址
    session[:return_to] = request.fullpath if request.get?
  end

  def redirect_back_or(default)
    redirect_to (session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def signed_in_check
    unless signed_in?
      # 记录检查前的页面url，以便在完成登录后跳转
      save_location
      redirect_to signin_url, notice:"Sign in please"    
    end
  end
  
  def current_users_path
    users_path + "/" + current_user[:id].to_s
  end
  
  def correct_user_check
    @user = User.find_by(:id => params[:id])
    if current_user.admin? || current_user?(@user)
    else
      flash[:error] = "Access forbidden operation"
      redirect_to root_path
    end
  end
  
  def admin_user_check
    redirect_to root_path unless current_user.admin?
  end
end
