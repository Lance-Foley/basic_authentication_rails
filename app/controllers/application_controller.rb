class ApplicationController < ActionController::Base


  def current_user
    @user = User.find_by(id: session[:user_id])
  end

  def valid_user_presence
    @user = User.find_by(id: session[:user_id])
    redirect_to new_logins_path unless @user
  end
end
