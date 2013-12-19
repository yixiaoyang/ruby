module ProfilesHelper
  def correct_user_check
    unless current_user?(@profile.user) 
      flash[:error] = "Access forbidden operation"
      if  current_user.profile.nil?
        redirect_to profiles_path
      else
        redirect_to current_user.profile        
      end
    end
  end
  
  def others_view_forbidden
    unless current_user?(@profile.user) or current_user.admin?
      flash[:error] = "Access forbidden operation"
      if  current_user.profile.nil?
        redirect_to profiles_path       
      end
    end
  end
end
