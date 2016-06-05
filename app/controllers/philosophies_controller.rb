class PhilosophiesController < ApplicationController
  before_action :require_user

  def new
    @philosophy = Philosophy.new
  end

  def create
    @philosophy = Philosophy.new(philosophy_params)
    @philosophy.user = current_user
    if @philosophy.save
      flash[:success] = "Philosophy successfully added"
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
    @philosophy = Philosophy.find(params[:id])
  end

  def update
    @philosophy = Philosophy.find(params[:id])
    if @philosophy.update_attributes(philosophy_params)
      flash[:success] = "Philosophy successfully updated"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def philosophy_params
    params.require(:philosophy).permit(:words)
  end

end
