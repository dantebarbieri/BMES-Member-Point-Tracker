# app/controllers/concerns/new_user.rb
# This concern guarantees the user is new to the system.
# Otherwise, it will redirect them away from the protected page. 

module NewUser
  extend ActiveSupport::Concern

  included do
    before_action :new_user?
  end

  def new_user?
  	@supplied_email = session[:app_user]["email"]
  	@member  = Member.find_by_email(@supplied_email)

  	if @member
  		redirect_to dashboard_path, notice: "You have already signed up!"
  	end
  end
end