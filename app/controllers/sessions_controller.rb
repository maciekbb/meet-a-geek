class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:create]


  def create
    user = User.where(name: params[:name]).first

    if user and user.authenticate(params[:password])
      render json: user, status: :created, serializer: UserWithAuthTokenSerializer
    else
      render json: { error: "bad credentials" }, status: 403
    end
  end
end
