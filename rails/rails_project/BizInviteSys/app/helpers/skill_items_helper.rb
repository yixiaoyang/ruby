module SkillItemsHelper
  def correct_user_check
    unless current_user?(@skill_item.profile.user) 
      flash[:error] = "Access forbidden operation"
      redirect_back_or @skill_item
    end
  end
  
  def others_view_forbidden
    unless current_user?(@skill_item.profile.user) or current_user.admin?
      flash[:error] = "Access forbidden operation"
      redirect_back_or @skill_item
    end
  end
end
