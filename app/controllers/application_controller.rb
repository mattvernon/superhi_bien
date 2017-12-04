class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before any page loads, find the current user
  before_action :find_current_user


  def find_current_user
    @current_user = User.find(session[:user_id])
  end

end
