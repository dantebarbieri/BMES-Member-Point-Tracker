# frozen_string_literal: true

# app/controllers/logout_controller.rb

class LogoutController < ApplicationController
  include LogoutHelper
  def logout
  	@kicked_out = false
  	if (session['app_user'])
  		@kicked_out = session['app_user']['kicked_out']
  	end

    reset_session

    if (@kicked_out)
    	flash['alert'] = 'That email is already taken by a user.'
    	redirect_to logout_url.to_s
	else
		flash['notice'] = 'You have been logged out.'
    	redirect_to logout_url.to_s
	end
  end
end
