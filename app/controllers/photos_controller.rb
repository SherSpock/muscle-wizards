class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prep
  before_action :user_owns_prep
  before_action :set_scope, only: [:index]

  def index
    @photos = @scope.order(created_at: :desc)
    @tags = Tag.all
  end

  def new
    @photo = Photo.new
    @tags = Tag.all
  end

  def create
    @photo = @prep.photos.new(photo_params)
    if @photo.save
      create_tag unless params[:photo][:tag].blank?
      flash[:success] = "Photo created!"
      redirect_to prep_photos_path(@prep)
    else
      render :new
    end
  end

  def edit
    @photo = Photo.find(params[:id])
    @tags = Tag.all
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.tagging.destroy if @photo.tagging
    if @photo.save
      create_tag unless params[:photo][:tag].blank?
      flash[:success] = "Photo updated!"
      redirect_to prep_photos_path(@prep)
    else
      render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to prep_photos_path(@prep)
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end

  def create_tag
    Tagging.create(photo_id: @photo.id, tag_id: params[:photo][:tag])
  end

  def set_scope
    if params[:tag]
      tag = Tag.find_by(name: params[:tag])
      @scope = tag.photos.where(prep_id: params[:prep_id])
    else
      @scope = @prep.photos
    end
  end

end
