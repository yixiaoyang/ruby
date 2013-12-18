module ProfilesHelper
  def correct_user_check
    unless current_user?(@profile.user) 
      flash[:error] = "Access forbidden operation"
      redirect_back_or current_user.profile
    end
  end
  
  def others_view_forbidden
    unless current_user?(@profile.user) or current_user.admin?
      flash[:error] = "Access forbidden operation"
      redirect_back_or current_user.profile
    end
  end
end
