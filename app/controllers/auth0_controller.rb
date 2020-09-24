class Auth0Controller < ApplicationController
	def callback
		# This stores all of the info that comes from Auth0
		session[:userinfo] = request.env['omniauth.auth']

		redirect_to '/dashboard'
	end

	def failure
		#show a failure page or redirect to an error page
		@error_msg = request.params['message']
	end
end
