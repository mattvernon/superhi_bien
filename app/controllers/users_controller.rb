class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show

    @user = User.find_by(username: params[:id])

  end

  def new
    # a form for adding a new user
    @user = User.new
  end

  def create

    # take params from form

    # create a new user
    @user = User.new(form_params)

    # if its valid and it saves, go to the list users page
    # if not, see the form with errors
    if @user.save
      # save the session with the user
      session[:user_id] = @user.id

      flash[:success] = "Welcome to Bien!"

      redirect_to root_path
    else
      render "new"
    end

  end


  # create params as seperate
  def form_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
