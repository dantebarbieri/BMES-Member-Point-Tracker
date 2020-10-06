# frozen_string_literal: true

# app/controllers/concerns/new_email.rb
# This concern guarantees the user has a new unique email. 
# Otherwise, it will redirect them away from the protected page.

module NewEmail
  extend ActiveSupport::Concern

  included do
    before_action :new_email?
  end

  def new_email?
    @supplied_email = session[:app_user]['email']
    @member = Member.find_by_email(@supplied_email)

    if (@member)
      session[:app_user]['kicked_out'] = true
    end

    redirect_to '/logout', alert: 'Signup Failed: There is already an account with this email address' if @member
    #redirect_to dashboard_path, notice: 'You have already signed up!' if @member
  end
end