class SkillItemsController < ApplicationController
  respond_to :html, :json
  
  before_action :set_skill_item, only: [:show, :edit, :update, :destroy]

  # GET /skill_items
  # GET /skill_items.json
  def index
    @skill_items = SkillItem.paginate(page: params[:page], per_page: 10)
  end

  # GET /skill_items/1
  # GET /skill_items/1.json
  def show
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

    respond_to do |format|
      if @skill_item.save
        format.html { redirect_to @skill_item, notice: 'Skill item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @skill_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @skill_item.errors, status: :unprocessable_entity }
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

  # DELETE /skill_items/1
  # DELETE /skill_items/1.json
  def destroy
    @skill_item.destroy
    respond_to do |format|
      format.html { redirect_to skill_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill_item
      @skill_item = SkillItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_item_params
      params[:skill_item]
    end
end
