class ResourceriesController < ApplicationController
  before_action :authenticate_user!
  before_action :user_owns_resource, only: [:create, :destroy]
  before_action :set_prep, only:           [:index, :show]

  def index
    @resources = @prep.resourceries.order(created_at: :desc).map { |rsrcry| rsrcry.resource }
    @unshared_resources = current_user.resources - @resources if current_user.coach
  end

  def new
    @resource   = Resource.find(get_resource_id)
    @resourcery = Resourcery.new
    @preps      = Prep.where(coach_id: current_user.id)
  end

  def create
    get_prep_ids.each do |id|
      Resourcery.create(resource_id: get_resource_id, prep_id: id) unless id.blank?
    end

    if params[:resourcery]
      flash[:success] = "Resource shared"
      redirect_to current_user
    else
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

  def get_resource_id
    params[:resource_id] || params[:resourcery] && params[:resourcery][:resource_id]
  end

  def get_prep_ids
    (params[:resourcery] && params[:resourcery][:prep_id]) || [params[:prep_id]]
  end

  def user_owns_resource
    resource_id = get_resource_id
    resource = resource_id ? Resource.find(resource_id) : Resourcery.find(params[:id]).resource
    if current_user != resource.user
      flash[:alert]  = "You don't have permission to do that"
      redirect_back(fallback_location: root_path)
    end
  end

end
