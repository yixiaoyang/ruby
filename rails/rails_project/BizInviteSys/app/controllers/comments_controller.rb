class CommentsController < ApplicationController
  respond_to :html, :json, :js
    
  include SessionsHelper
    
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :admin_user_check
 
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new(:user_id => current_user.id)
    @ajax_view = params[:ajax_view]
    if @ajax_view.nil?
      @ajax_view = false 
    end
    if params[:profile_id].nil?
      @error =   "You should specify a profile"
    else
      @comment.profile_id = params["profile_id"]
    end
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params) 
    if @comment.profile_id.nil?
      @error =   "You should specify a profile"
      logger.error @error
    else
      @profile = Profile.find(@comment.profile_id)
      respond_to do |format|
        if @comment.save
          format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
          format.json { render action: 'show', status: :created, location: @comment }
          format.js {}
        else
          format.html { render action: 'new' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
          format.js {render 'create_failed.js.erb'}
        end
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment_id = @comment.id
    @profile = @comment.profile
    @comment.destroy
    @error = nil;
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
      format.js {}
    end
  end

  def self.gen_tr_id(education_id)
    "comment_tr_id_#{education_id}"
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:score, :vluation, :profile_id, :user_id)
    end
end
