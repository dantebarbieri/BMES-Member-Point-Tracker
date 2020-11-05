class PreviousPointsController < ApplicationController
  include Secured
  include ExistingUser
  def index
    @member = Member.find_by_uid(session[:app_user]['uid'])
    unless @member.paid_dues?
      flash[:alert] = 'You must pay dues to see your points.'
      redirect_to('/dashboard')
    end
    @manual_points = ManualPoint.new
    @semesters = Semester.order(dates: :desc)
  end

  def show
    points_valid_member
  end
  def events
    @curr_semester = Semester.where(:semester_id == @sem_id)
    points_valid_member
  end

  def manual_points
    points_valid_member
  end

  def accomplishments
    points_valid_member
  end

  def select_semester
    sem_id = params[:index][:prev_semester_id]
    puts sem_id
    redirect_to("/previous_points/show/#{sem_id}")
  end
  def points_valid_member
    @member = Member.find_by_uid(session[:app_user]['uid'])
    @sem_id = params[:id]
    unless @member.paid_dues?
      flash[:alert] = 'You must pay dues to see your points.'
      redirect_to('/dashboard')
    end
  end
end
