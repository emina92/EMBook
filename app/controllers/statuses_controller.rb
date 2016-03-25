class StatusesController < ApplicationController
  before_action :set_status, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  before_filter :is_signed_in?
  
  # GET /statuses
  def index
    @statuses = Status.order("created_at desc").all
  end

  # GET /statuses/1
  def show
    @status = Status.find_by_id(params[:id])
  end

  # GET /statuses/new
  def new
    @status = current_user.statuses.new
    @status.build_document
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  def create
    @status = current_user.statuses.new(status_params)

    respond_to do |format|
      if @status.save
        current_user.create_activity(@status, "created")
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.json { render :show, status: :created, location: @status }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  def update
    respond_to do |format|
      if @status.update(status_params)
        current_user.create_activity(@status, "updated")
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { render :show, status: :ok, location: @status }
      else
        format.html { render :edit }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  def destroy
    @status.destroy
    respond_to do |format|
      current_user.create_activity(@status, "deleted")
      format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

   def is_signed_in?
    if !signed_in?
      redirect_to login_path, notice: "You must be logged in to access that page"
    end
  end

  private
    
    def set_status
      @status = current_user.statuses.find(params[:id])
    end

    def status_params
      params.require(:status).permit(:content, :user_id, document_attributes: [:file])
    end
end
