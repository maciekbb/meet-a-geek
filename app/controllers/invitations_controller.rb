class InvitationsController < ApplicationController
  def invite
    begin
      target_user = User.find(params[:user_id])
    rescue

    end

    invitation = Invitation.new(from: @user, to: target_user, message: params[:message])
    if invitation.save
      render json: invitation, status: :created
    else
      render json: invitation.errors, status: 422
    end
  end

  def accept
  end

  def incoming_invitations
  end

  def outcoming_invitations
  end
end
