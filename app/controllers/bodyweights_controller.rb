class BodyweightsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prep
  before_action :user_owns_prep


  def index
    @weights = @prep.bodyweights.order(created_at: :desc)
  end

  def new
    @weight = Bodyweight.new
  end

  def create
    multiply_by_ten
    @weight = @prep.bodyweights.new(weight_params)
    if @weight.save
      flash[:success] = "Weigh-in successful"
      redirect_to @prep
    else
      render :new
    end
  end

  private

  def weight_params
    params.require(:bodyweight).permit(:weight)
  end

  def multiply_by_ten
    weight = params[:bodyweight][:weight]
    params[:bodyweight][:weight] = weight.to_f * 10
  end

end
