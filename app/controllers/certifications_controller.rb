class CertificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_coach

  def new
    @certification = Certification.new
  end

  def create
    @certification = current_user.certifications.new(certification_params)
    if @certification.save
      flash[:success] = "New certification saved!"
      redirect_to current_user
    else
      render :new
    end
  end

  def edit
    @certification = Certification.find(params[:id])
  end

  def update
    @certification = Certification.find(params[:id])
    if @certification.user == current_user && @certification.update_attributes(certification_params)
      flash[:success] = "Certification successfully updated!"
      redirect_to current_user
    else
      render :edit
    end
  end

  def destroy
    @certification = Certification.find(params[:id])
    @certification.destroy if @certification.user == current_user
    flash[:success] = "Certification deleted"
    redirect_to current_user
  end

  private

  def certification_params
    params.require(:certification).permit(:name, :date_granted)
  end

end
