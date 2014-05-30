class TagsController < ApplicationController
  def index
    render json: @user.tags, status: :ok
  end

  def update
    params[:tags].each do |name|
      @user.tags << Tag.find_or_create_by(name: name)
    end

    head 204
  end

end
