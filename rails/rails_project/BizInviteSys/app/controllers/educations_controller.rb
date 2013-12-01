class EducationsController < ApplicationController
  respond_to :html, :json
  
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :set_education, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_check
  before_action :admin_user_check, only: [:index]
  
  # GET /educations
  # GET /educations.json
  def index
    @educations = Education.paginate(page: params[:page], per_page: 5)
  end

  # GET /educations/1
  # GET /educations/1.json
  def show
  end

  # GET /educations/new
  def new
    @education = Education.new
  end

  # GET /educations/1/edit
  def edit
  end

  # POST /educations
  # POST /educations.json
  def create
    @education = Education.new(education_params)

    respond_to do |format|
      if @education.save
        format.html { redirect_to @education, notice: 'Education was successfully created.' }
        format.json { render action: 'show', status: :created, location: @education }
      else
        format.html { render action: 'new' }
        format.json { render json: @education.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /educations/1
  # PATCH/PUT /educations/1.json
  def update
    p "update"
    respond_to do |format|
      p education_params
      p @education
      if @education.update(education_params)
        p "1"
        format.html { redirect_to @education, notice: 'Education was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { 
          p "update as HTML2"
          render action: 'edit' }
        format.json { 
          p "update as jscon no content2"
          render json: @education.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /educations/1
  # DELETE /educations/1.json
  def destroy
    @education.destroy
    respond_to do |format|
      format.html { redirect_to educations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_education
      @education = Education.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def education_params
      # !如果不用安全参数则会出现model forbidden错误
      params.require(:education).permit(:stime, :etime, :degree, :description, :profile_id)
    end
end
