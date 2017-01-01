class UsersController < ApplicationController
  before_action :require_user

  def index
    @coaches = User.where(coach: true)
  end

  def show
    @prep = Prep.find(params[:prep_id]) if params[:prep_id]
    @coached_preps = []
    if params[:id]
      user = User.find(params[:id])
      if coach_or_coached_athlete?(user) || user == current_user
        @user = user
        @coached_preps = current_user.coached_preps.order(updated_at: :desc).select { |prep| prep.athlete != prep.coach } if current_user == user
      else
        flash[:alert] = "You don't have permission to view that"
        redirect_back(fallback_location: root_path)
      end
    else
      @user = current_user
      @coached_preps = current_user.coached_preps.order(updated_at: :desc).select { |prep| prep.athlete != prep.coach }
    end
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "Profile updated successfully!"
      redirect_to current_user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :gender, :height, :phone_number, :bio, :avatar)
  end

end
