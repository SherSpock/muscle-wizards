class ResourceriesController < ApplicationController
  before_action :require_user
  before_action :user_owns_resource, only: [:create, :destroy]
  before_action :set_prep, only: [:index, :show]

  def index
    @resourceries = @prep.resourceries.order(created_at: :desc)
    @resources = @resourceries.map { |rsrcry| rsrcry.resource }
    if current_user == @prep.coach
      @unshared_resources = current_user.resources - @resources
    end
  end

  def new
    @resource = Resource.find(params[:resource])
    @resourcery = Resourcery.new
    @preps = Prep.where(coach_id: current_user.id)
  end

  def create
    if params[:resourcery]
      prep_ids = params[:resourcery][:prep_id]
      prep_ids.each do |id|
        Resourcery.create(resource_id: params[:resourcery][:resource_id], prep_id: id) unless id.blank?
      end
      flash[:success] = "Resource shared"
      redirect_to current_user
    else
      Resourcery.create(resource_id: params[:resource_id], prep_id: params[:prep_id])
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @resourcery = Resourcery.find(params[:id])
    @resourcery.destroy
    redirect_back(fallback_location: root_path)
  end


  private

  def resourcery_params
    params.require(:resourcery).permit(:resource_id, :prep_id)
  end

  def user_owns_resource
    if params[:resourcery]
      resource = Resource.find(params[:resourcery][:resource_id])
    elsif params[:resource_id]
      resource = Resource.find(params[:resource_id])
    else
      resourcery = Resourcery.find(params[:id])
      resource = resourcery.resource
    end
    if current_user != resource.user
      flash[:alert] = "You don't have permission to do that"
      redirect_back(fallback_location: root_path)
    end
  end

end
