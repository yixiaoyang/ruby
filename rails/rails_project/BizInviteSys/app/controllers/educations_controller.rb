class EducationsController < ApplicationController
  respond_to :html, :json, :js
  
  protect_from_forgery with: :exception
  include SessionsHelper
  include EducationsHelper

  before_action :set_education, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_check
  before_action :admin_user_check, only: [:index]
  before_action :correct_user_check, only: [:edit, :update, :destroy]
  before_action :others_view_forbidden, only:[:show]
  
  # 记录上一次的url位置
  after_action  :save_location
  
  # GET /educations
  # GET /educations.json
  def index
    @educations = current_user.profile.educations.paginate(page: params[:page], per_page: 5)
    @ajax_view = params[:ajax_view]
  end

  # GET /educations/1
  # GET /educations/1.json
  def show
  end

  # GET /educations/new
  def new
    @education = Education.new
    if current_user.profile.nil?
      flash[:error] = "You should new a profile"
      redirect_back_or educations_url
    end
    @education.profile_id = current_user.profile.id
    @ajax_view = params[:ajax_view]
  end

  # GET /educations/1/edit
  def edit
  end
  
  def self.gen_tr_id(education_id)
    "education_tr_id_#{education_id}"
  end

  # POST /educations
  # POST /educations.json
  def create
    @education = Education.new(education_params)
    if current_user.profile.nil?
      flash[:error] = "You should new a profile"
      redirect_back_or educations_url
    end
    
    @education.profile_id = current_user.profile.id
    p @education
    @ajax_view = params[:ajax_view]
    
    respond_to do |format|
      if @education.save
        format.html { redirect_to @education, notice: 'Education was successfully created.' }
        format.json { render action: 'show', status: :created, location: @education }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @education.errors, status: :unprocessable_entity }
        format.js {render 'create_failed.js.erb'}
      end
    end
  end

  # PATCH/PUT /educations/1
  # PATCH/PUT /educations/1.json
  def update
    respond_to do |format|
      if @education.update(education_params)
        format.html { redirect_back_or @education }
        format.json { head :no_content }
      else
        format.html { 
          render action: 'edit' }
        format.json { 
          render json: @education.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /educations/1
  # DELETE /educations/1.json
  def destroy
    @destroyed_id = @education.id
    @education.destroy
    respond_to do |format|
      format.html { redirect_to educations_url }
      format.json { head :no_content }
      format.js 
    end
  end

  def right_user?
    current_user?(@education.owner)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_education
      begin
      @education = Education.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Education id #{params[:id]} not found"
        redirect_to not_found_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def education_params
      # !如果不用安全参数则会出现model forbidden错误
      params.require(:education).permit(:stime, :etime, :degree, :description, :profile_id)
    end
end
