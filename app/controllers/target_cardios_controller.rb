class TargetCardiosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prep
  before_action :user_owns_prep

  def index
    @target_cardios = @prep.target_cardios.order(created_at: :desc)
  end

  def new
    @target_cardio = TargetCardio.new
  end

  def create
    @target_cardio = @prep.target_cardios.new(target_cardio_params)
    if @target_cardio.save
      flash[:success] = "Cardio added!"
      redirect_to @prep
    else
      render :new
    end
  end

  private

  def target_cardio_params
    params.require(:target_cardio).permit(:duration, :activity, :style)
  end
end
