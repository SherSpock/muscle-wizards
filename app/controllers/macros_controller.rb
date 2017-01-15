class MacrosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prep
  before_action :user_owns_prep

  def index
    @macros = @prep.macros.order(created_at: :desc)
    @target_macros = @prep.target_macros.order(created_at: :desc)
    # gets minimum and maximum values for setting y axis chart values
    @minmax = (@macros.map { |macro| macro.calories } + @target_macros.map { |macro| macro.calories }).minmax
  end

  def new
    @macro = Macro.new
  end

  def create
    @macro = @prep.macros.new(macro_params)
    if @macro.save
      flash[:success] = "Macros entered!"
      redirect_to @prep
    else
      render :new
    end
  end

  private

  def macro_params
    params.require(:macro).permit(:protein, :carbs, :fat, :fiber)
  end

end
