class PersonalDetailsController < ApplicationController
  respond_to :html, :json
  
  protect_from_forgery with: :exception
  include SessionsHelper
  include PersonalDetailsHelper
  
  before_action :set_personal_detail, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_check
  before_action :admin_user_check, only: [:index]
  before_action :correct_user_check, only: [:edit, :update, :destroy]
  before_action :others_view_forbidden, only:[:show]
  
  # GET /personal_details
  # GET /personal_details.json
  def index
    if current_user.admin?
      @personal_details = PersonalDetail.paginate(page: params[:page], per_page: 5)
    else
      redirect_to @personal_detail
    end
  end

  # GET /personal_details/1
  # GET /personal_details/1.json
  def show
    #redirect_to not_found_url
  end
  
  # GET /personal_details/new
  #   "personal_detail"=>{"name"=>"yixiaoyang",
  #       "age"=>"24",
  #       "email"=>"hityixaioyang@qq.com",
  #       "mobile"=>"1234567890123"},
  #       "sex"=>"0",
  #       "commit"=>"Save"}
  def new
    if new_allowed?
      if current_user.profile.personal_detail.nil?
        @personal_detail = PersonalDetail.new
        @personal_detail.profile_id = current_user.profile.id
        @ajax_view = params[:ajax_view]
      else
        redirect_to current_user.profile.personal_detail
      end
    end
  end

  # GET /personal_details/1/edit
  def edit
  end

  # POST /personal_details
  # POST /personal_details.json
  def create
    if new_allowed?
      redirect_to current_user.profile.personal_detail unless current_user.profile.personal_detail.nil?
      @personal_detail = PersonalDetail.new(personal_detail_params)
      respond_to do |format|
        if @personal_detail.save
          format.html { redirect_to @personal_detail, notice: 'Personal detail was successfully created.' }
          format.json { render action: 'show', status: :created, location: @personal_detail }
        else
          format.html { render action: 'new' }
          format.json { render json: @personal_detail.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /personal_details/1
  # PATCH/PUT /personal_details/1.json
  def update
    respond_to do |format|
      if @personal_detail.update(personal_detail_params)
        format.html { redirect_to @personal_detail, notice: 'Personal detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @personal_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personal_details/1
  # DELETE /personal_details/1.json
  def destroy
    @personal_detail.destroy
    respond_to do |format|
      format.html { redirect_to personal_details_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_personal_detail
      @personal_detail = PersonalDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def personal_detail_params
      if params[:profile_id].nil?
        flash[:error] = "Unkown error"
        params[:profile_id] = 0
        # redirect_to not_found_url
      end
      params.require(:personal_detail).permit(:name, :age, :email, :mobile, :sex, :profile_id)
    end
    
    def new_allowed?
      if current_user.admin?
        redirect_back_or not_found_url
        return false
      else
        if current_user.profile.nil?
          flash[:error] = "You should new a profile"
          redirect_back_or profiles_url
          return false
        end
      end
      true
    end
end
