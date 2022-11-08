class RegistrationsController < ApplicationController
  def new
    user = User.find_by(id: session[:user_id])
    redirect_to dashboards_path if user
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_logins_path
    else
      flash[:alert] = "Couldn't save the User!"
      render :new, status: :unprocessable_entity
    end
  end


  def destroy
    session.delete(:current_user_id)

    @_current_user = nil
    redirect_to root
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
