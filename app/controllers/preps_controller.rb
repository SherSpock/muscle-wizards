class PrepsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prep,       only: [:show, :self_coach]
  before_action :user_owns_prep, only: [:show, :self_coach]

  def new
    @prep    = Prep.new
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
    @coach  = @prep.coach
    @photos = @prep.photos.order(created_at: :desc).limit(3)
  end

  def self_coach
    @prep.coach_id = @prep.user_id
    @prep.save
    redirect_to @prep
  end

  private

  def prep_params
    params.require(:prep).permit(:title, contests_attributes: [:title, :date, :url])
  end

end
