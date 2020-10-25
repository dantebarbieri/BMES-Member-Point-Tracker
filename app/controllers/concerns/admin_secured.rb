# frozen_string_literal: true

# app/controllers/concerns/new_user.rb
# This concern guarantees the user is and admin.
# Otherwise, it will redirect them away from the protected page.

module AdminSecured
  extend ActiveSupport::Concern

  included do
    before_action :is_admin?
  end

  def is_admin?
    # @supplied_email = session[:app_user]['email']
    # @member = Member.find_by_email(@supplied_email)

    # Need to find user by id
    @supplied_uid = session[:app_user]['uid']
    @member = Member.find_by_uid(@supplied_uid)

    redirect_to dashboard_path, alert: 'You are not an admin.' unless @member.is_admin?
  end
end
