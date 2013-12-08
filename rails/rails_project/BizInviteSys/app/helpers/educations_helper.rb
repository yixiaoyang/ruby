module EducationsHelper
  def correct_user_check
    unless current_user?(@education.profile.user) 
      flash[:error] = "Access forbidden operation"
      redirect_back_or @education
    end
  end
  
  def others_view_forbidden
    unless current_user?(@education.profile.user) or current_user.admin?
      flash[:error] = "Access forbidden operation"
      redirect_back_or @education
    end
  end
end
