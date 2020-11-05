# frozen_string_literal: true

# app/controllers/concerns/executive_secured.rb
# This concern guarantees the user is an executive.
# Otherwise, it will redirect them away from the protected page.

module ExecutiveSecured
  extend ActiveSupport::Concern

  included do
    before_action :is_executive?
  end

  def is_executive?
    # @supplied_email = session[:app_user]['email']
    # @member = Member.find_by_email(@supplied_email)

    # Need to find user by id
    @supplied_uid = session[:app_user]['uid']
    @member = Member.find_by_uid(@supplied_uid)

    redirect_to dashboard_path, alert: 'You are not an executive.' unless @member.executive_admin?
  end
end
