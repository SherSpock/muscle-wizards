class PhotosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prep
  before_action :user_owns_prep
  before_action :set_photo, only: [:edit, :update, :destroy]
  before_action :set_tags,  only: [:index, :new, :edit]

  def index
    @photos = set_scope
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = @prep.photos.new(photo_params)
    if @photo.save
      create_tag if tag_set?
      flash[:success] = "Photo created!"
      redirect_to prep_photos_path(@prep)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @photo.tagging.destroy if @photo.tagging
    if @photo.save
      create_tag if tag_set?
      flash[:success] = "Photo updated!"
      redirect_to prep_photos_path(@prep)
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to prep_photos_path(@prep)
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def set_tags
    @tags = Tag.all
  end

  def create_tag
    Tagging.create(photo_id: @photo.id, tag_id: params[:photo][:tag])
  end

  def tag_set?
    params[:photo][:tag]
  end

  def set_scope
    if params[:tag]
      tag    = Tag.find_by(name: params[:tag])
      @scope = tag.photos.where(prep_id: params[:prep_id])
    else
      @scope = @prep.photos
    end
    @scope.order(created_at: :desc)
  end

end
