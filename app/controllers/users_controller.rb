class UsersController < ApplicationController
  def index
    render json: @user.matches, status: :ok
  end

  def create
    user = User.new(user_attributes)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: 422
    end
  end

  def update
    user = @user

    if user.update(user_attributes)
      render json: user, status: :ok
    else
      render json: user.errors, status: 422
    end
  end

  def delete
    head 204
  end

  def user_attributes
    new_params = params.require(:user).permit(:name, { coordinate_attributes: { location: [] } })
    new_params[:coordinate_attributes][:location] = new_params[:coordinate_attributes][:location].map(&:to_f)
    new_params
  end
end
