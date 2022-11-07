class LoginsController < ApplicationController
  def new
    user = User.find_by(id: session[:user_id])
    redirect_to dashboards_path if user
    @user = User.new
  end

  def create
    @user = User.find_by(login_params)

    if @user
      session[:user_id] = @user.id
      redirect_to dashboards_path
    else
      flash[:alert] = "Email or password is wrong!"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:current_user_id)

    @_current_user = nil
    redirect_to root
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
