class SkillItemsController < ApplicationController
  respond_to :html, :json  
  
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :set_skill_item, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_check
  before_action :admin_user_check, only: [:index]
  
  # GET /skill_items
  # GET /skill_items.json
  def index
    @skill_items = SkillItem.paginate(page: params[:page], per_page: 10)
  end

  # GET /skill_items/1
  # GET /skill_items/1.json
  def show
#     if @skill_item.nil?
#       @skill_item = SkillItem.find(skill_item_params)
#     end
#     @skill = SkillItem.find(@skill_item.skill_id)
#     rescue ActiveRecord::RecordNotFound
#       flash[:error] = "Skill items id #{params[:id]} not found"
#     end
  end

  # GET /skill_items/new
  def new
    @skill_item = SkillItem.new
  end

  # GET /skill_items/1/edit
  def edit
  end

  # POST /skill_items
  # POST /skill_items.json
  def create
    @skill_item = SkillItem.new(skill_item_params)
    if params[:profile_id].nil?
      flash[:error] = "Profile not found";
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @skill_item.errors, status: :unprocessable_entity }
        format.js{render 'create.js.erb', succeed:false}
      end
    else
      respond_to do |format|
        if @skill_item.save
          format.html { redirect_to @skill_item, notice: 'Skill item was successfully created.' }
          format.json { render action: 'show', status: :created, location: @skill_item }
          format.js{render 'create.js.erb', succeed:true}
        else
          format.html { render action: 'new' }
          format.json { render json: @skill_item.errors, status: :unprocessable_entity }
          format.js{render 'create.js.erb', succeed:false}
        end
      end
    end

    
  end

  # PATCH/PUT /skill_items/1
  # PATCH/PUT /skill_items/1.json
  def update
    respond_to do |format|
      if @skill_item.update(skill_item_params)
        format.html { redirect_to @skill_item, notice: 'Skill item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @skill_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def renew
    @error = nil
    @deled_skill_item_ids = []
    @newed_skill_item_ids = []
    
    skill_ids = params[:skill_ids].map {|s| s.to_i }
    profile_id = params[:profile_id]
    @profile = Profile.find(profile_id)
    old_skill_ids = @profile.skill_ids_all
    
    del_skill_ids = old_skill_ids - skill_ids
    new_skill_ids = skill_ids - old_skill_ids

    ActiveRecord::Base.transaction do  
      begin
        # add new items
        new_skill_ids.each { |skill_id|
          item = SkillItem.new(:skill_id => skill_id, :profile_id => profile_id)
          item.save! 
          @newed_skill_item_ids.push(item.id) unless item.nil?
        }
        # delete old items
        del_skill_ids.each { |skill_id|
          item = SkillItem.find_by(:skill_id => skill_id, :profile_id => profile_id)
          @deled_skill_item_ids.push(item.id) unless item.nil?
          item.destroy unless item.nil?
        }
      rescue Exception => ex  
        @error = "Skill_items saved failed, msg :#{ex.message}"
        logger.error(@error)
      end  
    end  
    
     #if Rails.env.development? 
      p "deleted :#{@deled_skill_item_ids}"
      p "added:#{@newed_skill_item_ids}"
    #end 
    
    respond_to do |format|
      format.html { redirect_to skill_items_url }
      format.js { render 'renew.js.erb'}
    end
  end
  
  # DELETE /skill_items/1
  # DELETE /skill_items/1.json
  def destroy
    @destroy_id = @skill_item.id
    @skill_item.destroy
    @error = nil
    respond_to do |format|
      format.html { redirect_to skill_items_url }
      format.js { render 'destroy.js.erb', :succeed => true }
    end
  end
  
  def self.gen_tr_id(id)
    "skill_items_tr_id_#{id}"
  end
  def self.gen_tr_id2(id)
    "skill_items_tr_id_#{id}_2"
  end
  def self.gen_slt_id(id)
    "skill_items_slt_id_#{id}"
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill_item
      @skill_item = SkillItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_item_params
      params.require(:skill_item).permit(:skill_id, :profile_id, :id)
    end
end
