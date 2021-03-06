class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :new_message_count

  # Preps
  def set_prep
    @prep = Prep.find(params[:prep_id])
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

  # Coaches
  
  def require_coach
    redirect_to current_user unless current_user.coach
  end

  def coach_or_coached_athlete?(user)
    user.coach || prep_includes_user?(user)
  end

  def new_message_count
    @prep.conversation.unread_message_count(current_user) if @prep.conversation
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender, :age, :height, :phone_number, :avatar, :coach])
  end

  private
  # override the devise method for where to go after signing out because theirs
  # always goes to the root path.
  def after_sign_out_path_for(resource)
    home_path
  end
end
