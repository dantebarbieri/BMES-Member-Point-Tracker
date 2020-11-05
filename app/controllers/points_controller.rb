# frozen_string_literal: true

class PointsController < ApplicationController
  include Secured
  include ExistingUser

  def index
    points_valid_member
  end

  def events
    points_valid_member
    sem = Semester.current_semester
    @events = @member.events.where(start_time: sem.dates.begin..sem.dates.end)
  end

  def manual_points
    points_valid_member
  end

  def accomplishments
    points_valid_member
  end

  def points_valid_member
    @member = Member.find_by_uid(session[:app_user]['uid'])
    unless @member.paid_dues?
      flash[:alert] = 'You must pay dues to see your points.'
      redirect_to('/dashboard')
    end
  end
end
