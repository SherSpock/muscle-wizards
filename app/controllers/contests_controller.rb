class ContestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prep
  before_action :user_owns_prep

  def index
    @contests = @prep.contests.order(created_at: :desc)
  end

  def new
    @contest = Contest.new
  end

  def create
    @contest = @prep.contests.new(contest_params)
    if @contest.save
      flash[:success] = "Contest created!"
      redirect_to @prep
    else
      render :new
    end
  end

  def contest_params
    params.require(:contest).permit(:title, :date, :url)
  end

end
