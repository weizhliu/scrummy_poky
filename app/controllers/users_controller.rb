class UsersController < ApplicationController
  before_action :set_user

  def edit; end

  def update
    @user.update(user_params)
    render @user
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
