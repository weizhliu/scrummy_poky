class ApplicationController < ActionController::Base
  def set_user
    @user =
      User.find_by(uuid: session[:user_uuid]) ||
      User.create
    session[:user_uuid] = @user.uuid
  end
end
