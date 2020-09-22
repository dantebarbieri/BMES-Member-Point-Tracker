class DashboardController < ApplicationController
  #Requires the user to be logged in to view this page
  include Secured

  def show
  	@session_info = session[:userinfo]
  	@user_info = @session_info["info"]
  	@name = @user_info["name"]
  	@email = @user_info["email"]

  	# Something like this maybe?
  	# session[:app_user] = User.find()
  end
end
