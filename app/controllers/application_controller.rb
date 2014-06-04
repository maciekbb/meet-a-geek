class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :authenticate

  protected

  def authenticate
    authenticat_with_token or render_unauthorized
  end

  def authenticat_with_token
    authenticate_with_http_token do |token|
      @user = User.find_by(auth_token: token)
    end
  end

  def render_unauthorized
    render json: "Bad credentials", status: 401
  end
end
