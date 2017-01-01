class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :new_message_count

  def set_prep
    @prep = Prep.find(params[:prep_id])
  end

  def require_user
    redirect_to home_path unless current_user
  end

  def require_coach
    redirect_to current_user unless current_user.coach
  end

  def coach_or_coached_athlete?(user)
    user.coach || prep_includes_user?(user)
  end

  def prep_includes_user?(user)
    current_user.coached_preps.where(athlete: user).any?
  end

  def user_owns_prep
    unless current_user == @prep.athlete || current_user == @prep.coach
      flash[:alert] = "You are not authorized to do that"
      redirect_back(fallback_location: root_path)
    end
    true
  end

  def new_message_count
    @prep.conversation.unread_message_count(current_user) if @prep.conversation
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender, :age, :height, :phone_number, :avatar, :coach])
  end
end
