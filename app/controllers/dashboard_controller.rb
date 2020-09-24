class DashboardController < ApplicationController
  #Requires the user to be logged in to view this page
  include Secured

  def show
  	@session_info = session[:userinfo]
		@user_info = @session_info["info"]
  	@name = @user_info["name"]
		@email = @user_info["email"]
		@member = Member.find_by(:email => @email)
		unless @member
			@member = Member.create(:name => @name, :email => @email)
		end
		session[:app_info] = {:current_user => @member}
		@dues_paid = @member.paid_dues?
		@attendance_points = @member.attendance_points
		@accomplishments_points = @member.accomplishment_points
		@manual_points = @member.manual_points_received
		@total_points = @member.total_points
  end
end
