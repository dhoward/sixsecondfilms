class PromptItemsController < ApplicationController
  # GET /prompt_items
  # GET /prompt_items.json
  def index
    @prompt_items = PromptItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prompt_items }
    end
  end

  # GET /prompt_items/1
  # GET /prompt_items/1.json
  def show
    @prompt_item = PromptItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @prompt_item }
    end
  end

  # GET /prompt_items/new
  # GET /prompt_items/new.json
  def new
    @prompt_item = PromptItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @prompt_item }
    end
  end

  # GET /prompt_items/1/edit
  def edit
    @categories = PromptCategory.all
    @prompt_item = PromptItem.find(params[:id])
  end

  # POST /prompt_items
  # POST /prompt_items.json
  def create
    @prompt_item = PromptItem.new(params[:prompt_item])

    respond_to do |format|
      if @prompt_item.save
        format.html { redirect_to @prompt_item, notice: 'Prompt item was successfully created.' }
        format.json { render json: @prompt_item, status: :created, location: @prompt_item }
      else
        format.html { render action: "new" }
        format.json { render json: @prompt_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /prompt_items/1
  # PUT /prompt_items/1.json
  def update
    @prompt_item = PromptItem.find(params[:id])

    respond_to do |format|
      if @prompt_item.update_attributes(params[:prompt_item])
        format.html { redirect_to @prompt_item, notice: 'Prompt item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @prompt_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prompt_items/1
  # DELETE /prompt_items/1.json
  def destroy
    @prompt_item = PromptItem.find(params[:id])
    @prompt_item.destroy

    respond_to do |format|
      format.html { redirect_to prompt_items_url }
      format.json { head :no_content }
    end
  end
end
