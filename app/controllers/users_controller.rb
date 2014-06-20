class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def matches
    render json: @user.matches(params[:tags]), status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    user = User.new(user_attributes)

    if user.save
      render json: user, status: :created, serializer: UserWithAuthTokenSerializer
    else
      render json: user.errors, status: 422
    end
  end

  def update
    if @user.update(user_attributes)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: 422
    end
  end

  def destroy
    # TO DO
    head 204
  end

  def avatar
    another_user = User.find(params[:id])

    if @user.able_to_meet? another_user
      content = another_user.avatar.read
      send_data content, type: another_user.avatar.file.content_type, disposition: "inline"
    else
      render json: "Not authorized", status: 401
    end
  end

  private

  def user_attributes
    new_params = params.require(:user).permit(:name, :avatar, { coordinate_attributes: { location: [] } })
    if new_params[:coordinate_attributes]
      new_params[:coordinate_attributes][:location] = new_params[:coordinate_attributes][:location].map(&:to_f)
    end
    new_params
  end
end
