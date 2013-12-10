module PersonalDetailsHelper
  def correct_user_check
    unless current_user?(@personal_detail.profile.user) 
      flash[:error] = "Access forbidden operation"
      redirect_back_or @personal_detail
    end
  end
  
  def others_view_forbidden
    unless current_user?(@personal_detail.profile.user) or current_user.admin?
      flash[:error] = "Access forbidden operation"
      redirect_to current_user.profile.personal_detail
    end
  end
  
  def self.gen_tr_id(id)
    "personal_detail_tr_id_#{id}"
  end
end
