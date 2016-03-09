class PicturesController < ApplicationController
  before_filter :find_user
  before_filter :find_album
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_filter :add_breadcrumbs
 
  def index
    @pictures = @album.pictures.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    add_breadcrumb @picture.caption
  end

  # GET /pictures/new
  def new
    @picture = @album.pictures.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = @album.pictures.new(picture_params)
    @picture.user = current_user
    respond_to do |format|
      if @picture.save
        current_user.create_activity(@picture, "created")
        format.html { redirect_to album_pictures_path(@album), notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        current_user.create_activity(@picture, "created")
        format.html { redirect_to album_pictures_path(@album), notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      current_user.create_activity(@status, "deleted")
      format.html { redirect_to album_pictures_url(@album), notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def url_options
    { profile_name: params[:profile_name] }.merge(super)
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:album_id, :user_id, :caption, :description, :asset)
    end

    def add_breadcrumbs
      add_breadcrumb @user.first_name, profile_path(@user)
      add_breadcrumb "Albums", albums_path
      add_breadcrumb "Pictures", album_pictures_path(@album)
    end

    def find_user
      @user = User.find_by_profile_name(params[:profile_name])
    end

    def find_album
      if signed_in? && current_user.profile_name == params[:profile_name]
        @album = current_user.albums.find(params[:album_id])
      else
        @album = @user.albums.find(params[:album_id])
      end
    end

    def set_picture
       @picture = @album.pictures.find(params[:id])
    end
end
