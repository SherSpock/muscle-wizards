class PrepsController < ApplicationController
  before_action :authenticate_user!

  def new
    @prep = Prep.new
    @contest = @prep.contests.new
  end

  def create
    @prep = current_user.preps.new(prep_params)
    if @prep.save
      flash[:success] = "New Contest Prep started. Good luck!"
      redirect_to @prep
    else
      render :new
    end
  end

  def show
    @prep = Prep.find(params[:id])
    if user_owns_prep
      @coach = @prep.coach
      @photos = @prep.photos.order(created_at: :desc).limit(3)
    end
  end

  def self_coach
    @prep = Prep.find(params[:prep_id])
    @prep.coach_id = @prep.user_id if user_owns_prep
    @prep.save
    redirect_to @prep
  end

  private

  def prep_params
    params.require(:prep).permit(:title, contests_attributes: [:title, :date, :url])
  end

end
