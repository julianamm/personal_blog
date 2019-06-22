class UsersController < ApplicationController
  before_action :authenticate_user!

  def new
      @user = User.new
  end
  def create
      @user = User.new user_params

      if @user.save
      session[:user_id] = @user.id
      redirect_to home_path
      else
      render :new
      end
  end

  def edit
      @user = User.find params[:id]
  end

  def update
      find_user
      if @user.update(user_params)
        flash[:sucess] = "Thank you! Your profile has been updated!"
        redirect_to user_path(@user.id)
      else
        render :edit
      end
  end

  def edit_password
      find_user
  end

  def update_password
      user = User.find_by_email(current_user.email).try(:authenticate, params[:user][:current_password])
      if user 
          if params[:user][:current_password] == params[:user][:new_password] 
              flash.now[:error] = "Current Password can't be equal the New Password!"
              find_user
              render 'edit_password'
          else
              if params[:user][:new_password] == params[:user][:password_confirmation] 
                  @user.update(password: params[:user][:new_password])
                  flash[:success] = "Profile updated"
                  redirect_to home_path
              else
                  flash.now[:error] = "New Password doesn't match the Password Confirmation"
                  find_user
                  render 'edit_password'
              end
          end
      else
        flash.now[:error] = "Incorrect Current Password"
        find_user
        render 'edit_password'
      end
  end
  

  private
  def user_params
      params.require(:user).permit(
    :name, :email, :current_password, :new_password, :password_confirmation
  )
  end

  def find_user
      @user = User.find params[:id]
  end
  
end
