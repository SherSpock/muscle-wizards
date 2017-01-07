class CardiosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prep
  before_action :user_owns_prep

    def index
      @cardios = @prep.cardios.order(created_at: :desc)
      @target_cardios = @prep.target_cardios.order(created_at: :desc)
      # gets minimum and maximum values for setting y axis chart values
      @minmax = (@cardios.map { |cardio| cardio.duration} + @target_cardios.map { |cardio| cardio.duration }).minmax
    end

    def new
      @cardio = Cardio.new
    end

    def create
      @cardio = @prep.cardios.new(cardio_params)
      if @cardio.save
        flash[:success] = "Cardio added!"
        redirect_to @prep
      else
        render :new
      end
    end

    private

    def cardio_params
      params.require(:cardio).permit(:duration, :activity, :style)
    end
end
