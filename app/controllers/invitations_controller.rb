class InvitationsController < ApplicationController
  def invite
    begin
      target_user = User.find(params[:user_id])
    rescue
      # render error ?
    end

    invitation = Invitation.new(from: @user, to: target_user, message: params[:message])
    if invitation.save
      render json: invitation, status: :created
    else
      render json: { errors: invitation.errors }, status: 422
    end
  end

  def accept
    invitation = @user.incoming_invitations.find(params[:invitation_id])
    invitation.accepted = true

    if invitation.save
      head 204
    else
      render json: invitation.errors, status: 422
    end
  end

  def reject
    invitation = @user.incoming_invitations.find(params[:invitation_id])
    invitation.rejected = true

    if invitation.save
      head 204
    else
      render json: invitation.errors, status: 422
    end
  end

  def cancel
    invitation = @user.accepted_invitations.find do |inv|
      inv.id.to_s == params[:invitation_id]
    end

    invitation.destroy
    head 200
  end

  def incoming_invitations
    invitations = @user.incoming_invitations
    render json: invitations, status: 200
  end

  def outcoming_invitations
    invitations = @user.outcoming_invitations
    render json: invitations, status: 200
  end
end
