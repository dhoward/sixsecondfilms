class PromptCategoriesController < ApplicationController

  layout "admin"

  before_filter :authenticate_admin!

  # GET /prompt_categories
  # GET /prompt_categories.json
  def index
    @prompt_categories = PromptCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prompt_categories }
    end
  end

  # GET /prompt_categories/new
  # GET /prompt_categories/new.json
  def new
    @prompt_category = PromptCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @prompt_category }
    end
  end

  # GET /prompt_categories/1/edit
  def edit
    @prompt_category = PromptCategory.find(params[:id])
  end

  # POST /prompt_categories
  # POST /prompt_categories.json
  def create
    @prompt_category = PromptCategory.new(params[:prompt_category])

    respond_to do |format|
      if @prompt_category.save
        format.html { redirect_to :action => "index" }
        format.json { render json: @prompt_category, status: :created, location: @prompt_category }
      else
        format.html { render action: "new" }
        format.json { render json: @prompt_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /prompt_categories/1
  # PUT /prompt_categories/1.json
  def update
    @prompt_category = PromptCategory.find(params[:id])

    respond_to do |format|
      if @prompt_category.update_attributes(params[:prompt_category])
        format.html { redirect_to :action => "index" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @prompt_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prompt_categories/1
  # DELETE /prompt_categories/1.json
  def destroy
    @prompt_category = PromptCategory.find(params[:id])
    @prompt_category.destroy

    respond_to do |format|
      format.html { redirect_to prompt_categories_url }
      format.json { head :no_content }
    end
  end
end
