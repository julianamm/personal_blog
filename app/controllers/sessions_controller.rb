class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    # render json: params
      
    if user&.authenticate(params[:session][:password])
      flash[:success] = "Thanks for signing in, #{user.name}!"
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash[:danger] = "Invalid email or password"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path
  end
end
