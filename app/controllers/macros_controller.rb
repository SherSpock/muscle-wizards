class MacrosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prep
  before_action :user_owns_prep

  def index
    @macros = @prep.macros.order(created_at: :asc)
    @chart_macros = @macros.reverse
    if @macros.length > 10
      @over_ten = true
      @chart_macros = @macros[-10..-1].reverse
    end
    if params[:m]
      @over_ten = false
      @chart_macros = @macros.reverse
    end
    @target_macros = @prep.target_macros.order(created_at: :asc)
    @chart_target_macros = @target_macros.reverse
    if @target_macros.length > 10
      @over_ten2 = true
      @chart_target_macros = @target_macros[-10..-1].reverse
    end
    if params[:tm]
      @over_ten2 = false
      @chart_target_macros = @target_macros.reverse
    end
    @minmax = (@macros.map { |macro| macro.calories } + @target_macros.map { |macro| macro.calories }).minmax
  end

  def new
    @macro = Macro.new
  end

  def create
    @macro = @prep.macros.new(macro_params)
    if @macro.save
      flash[:success] = "Macros entered"
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
