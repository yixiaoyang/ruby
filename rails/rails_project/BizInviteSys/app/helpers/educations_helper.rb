module EducationsHelper
  def correct_user
    @education = Education.find(params[:id])
    profile = Profile.find(@education.profile_id) unless @education.nil?
    user = User.find(profile.user_id) unless profile.nil?
    unless current_user?(user) 
      flash[:error] = "Access forbidden operation"
      redirect_back_or @education
    end
  end
end
