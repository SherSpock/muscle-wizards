class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_prep
  before_action :user_owns_prep, only: [:new, :create]
  before_action :set_coach, except: [:destroy]

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation      = Invitation.new(invitation_params)
    @invitation.user = @coach
    @invitation.prep = @prep
    if @invitation.save
      flash[:success] = "Invitation sent!"
      InvitationMailer.invite(@coach, @prep).deliver_later
      redirect_to @prep
    else
      render :new
    end
  end

  def show
    @invitation = @prep.invitation
    @user = @prep.athlete
  end

  def destroy
    @invitation = Invitation.find_by(user_id: params[:id])
    @coach = User.find(@invitation.user_id)
    @invitation.destroy
    InvitationMailer.reject(@coach, @prep).deliver_later
    redirect_to @prep
  end

  def accept_invite
    @invitation = @prep.invitation
    @prep.coach_id = @coach.id
    @prep.save
    InvitationMailer.accept(@prep.athlete, @prep).deliver_later
    @invitation.destroy
    redirect_to @prep
  end

  private

  def invitation_params
    params.require(:invitation).permit(:message)
  end

  def set_coach
    @coach = User.find(params[:id])
  end
end
