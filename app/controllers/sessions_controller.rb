class SessionsController < ApplicationController

  def new
    # login form
  end

  def create
    # actually try and login
    @form_data = params.require(:session)

    # pull out the username and password from the form data
    @username = @form_data[:username]
    @password = @form_data[:password]

    # check user is who they say they are
    @user = User.find_by(username: @username).try(:authenticate, @password)

    # if there is a user present
    if @user
      # save this user to that user's session
      session[:user_id] = @user.id

      redirect_to root_path
    else
      render "new"
    end

  end

  def destroy
    # log out
    # remove the sessions completely
    reset_session

    #redirect to login page
    redirect_to new_session_path
  end

end
