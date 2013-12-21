# TODO:权限限定

class ProfilesController < ApplicationController
  respond_to :html, :json
  
  protect_from_forgery with: :exception
  include SessionsHelper
  include ProfilesHelper
  
  before_action :signed_in_check
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :update_stat]
  before_action :admin_user_check, only: [:destroy]
 
  before_action :correct_user_check, only: [:edit, :update]
  before_action :others_view_forbidden, only:[:show]
  
  def user
    p User.find_by(:id => self.user_id)
    User.find_by(:id => self.user_id)
  end
  
  # GET /profiles
  # GET /profiles.json
  def index
    # sort string
    sort = params[:sort]
    direction = params[:direction]
    sort ||= "id"
    direction ||= "asc"
    sort_str = sort + " " + direction
    
    # search conditions
    stat_gt = params[:stat_gt]
    stat_eq = params[:stat_eq]
    if stat_eq.nil?
      stat_gt ||= "0"
      stat_conditions =  ['stat > ?', stat_gt];
    else
      stat_conditions = ['stat = ?', stat_eq];
    end
    
    if current_user.admin?
      profiles = Profile.where(stat_conditions)
      @profiles = profiles.order(sort_str).paginate(page: params[:page], per_page: 10)
    else
      myprofiles = Profile.where(:user_id => current_user.id).order(sort_str)
      @profiles = myprofiles.paginate(page: params[:page], per_page: 10)
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    begin
     @user = User.find(@profile.user_id)
    rescue ActiveRecord::RecordNotFound
       redirect_to not_found_path
    end
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
    @profile.user_id = current_user.id
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # update status of profile
  def update_stat
    @stat = params[:stat]
    p @stat
    if @stat.nil?
      @error = "Update status failed"
    else
      if !current_user.admin? and @stat!="0" and @stat!="1"
        @error = "Access Forbidden"
      else
        @profile.stat = @stat
        respond_to do |format|
          if @profile.update_attributes(:stat => @stat)
            format.js{}
          else
            format.js{}
          end
        end  
      end
    end
  end
  
  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      begin
        @profile = Profile.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to not_found_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:category, :stat, :score, :user_id)
    end
end
