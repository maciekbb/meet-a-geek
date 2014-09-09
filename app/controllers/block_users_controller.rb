class BlockUsersController < ApplicationController
  def create
    @user.block_user_with_id(params[:user_id])
    head 200
  end

  def destroy
    @user.unblock_user_with_id(params[:user_id])
    head 200
  end
end
