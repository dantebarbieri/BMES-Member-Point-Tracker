class DashboardController < ApplicationController
  #Requires the user to be logged in to view this page
  include Secured

  def show
  	@session_info = session[:userinfo]
  	@user_info = @session_info["info"]
  	@name = @user_info["name"]
  	@email = @user_info["email"]

  	session[:app_user] = {"name" => @name, "email" => @email}

  	# Check if user already exits, if not, then redirect to signup

  	@member = Member.find_by_email(@email)

  	unless @member
  		redirect_to controller: :signup, action: :new
  	end

  	# Something like this maybe?
  	# session[:app_user] = User.find()
  end
end
