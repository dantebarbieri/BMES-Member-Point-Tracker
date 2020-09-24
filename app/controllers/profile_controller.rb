class ProfileController < ApplicationController
	include Secured
	include ExistingUser

	def show
		@supplied_email = session[:app_user]["email"]
  		@member  = Member.find_by_email(@supplied_email)
	end

	def edit
		@supplied_email = session[:app_user]["email"]
  		@member  = Member.find_by_email(@supplied_email)
	end

	def update
		@supplied_email = session[:app_user]["email"]
  		@member  = Member.find_by_email(@supplied_email)

  		if (@member.update(member_params))
			redirect_to profile_path, notice: 'Your data was updated.'
		else
			render 'edit'
		end
	end

	private def member_params
		params.require(:member).permit(:name, :class_year)
	end
end
