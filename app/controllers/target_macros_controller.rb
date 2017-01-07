class TargetMacrosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prep
  before_action :user_owns_prep

  def index
    @target_macros = @prep.target_macros.order(created_at: :desc)
  end

  def new
    @target_macro = TargetMacro.new
  end

  def create
    @target_macro = @prep.target_macros.new(target_macro_params)
    if @target_macro.save
      flash[:success] = "Macros entered"
      redirect_to @prep
    else
      render :new
    end
  end

  private

  def target_macro_params
    params.require(:target_macro).permit(:protein, :carbs, :fat, :fiber)
  end
end
