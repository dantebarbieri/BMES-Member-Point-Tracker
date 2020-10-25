# frozen_string_literal: true

class DashboardController < ApplicationController
  # Requires the user to be logged in to view this page
  include Secured
  include ExistingUser

  def show
    # @member = Member.find_by_email(session[:app_user]['email'])
    @member = Member.find_by_uid(session[:app_user]['uid'])
    @name = @member.name
    @dues_paid = @member.paid_dues?
    @attendance_points = @member.attendance_points
    @accomplishments_points = @member.accomplishment_points
    @manual_points = @member.manual_points_received
    @total_points = @member.total_points
  end
end
