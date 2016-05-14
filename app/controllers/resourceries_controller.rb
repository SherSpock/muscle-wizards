class ResourceriesController < ApplicationController
  before_action :require_user

  def create
    @resourcery = Resourcery.new(resourcery_params)
    if @resourcery.save
      flash[:success] = "Resource successfully shared"
    else
      flash[:alert] = "Resource already shared with #{Prep.find(params[:resourcery][:prep_id]).athlete.name}"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def resourcery_params
    params.require(:resourcery).permit(:resource_id, :prep_id)
  end

end
