# frozen_string_literal: true

class ManualPointsController < ApplicationController
  include Secured
  include ExistingUser
  include AdminSecured

  def index
    @manual_points = ManualPoint.all
  end

  def show
    @manual_points = ManualPoint.find(params[:id])
  end

  def new
    @manual_points = ManualPoint.new
    @members = Member.order(:name)
  end

  def create
    @manual_points = ManualPoint.new(manual_points_params)
    if @manual_points.save
      flash[:notice] = 'Points Manually Created Successfully'
      redirect_to(manual_points_path)
    else
      render('new')
    end
  end

  def edit
    @manual_points = ManualPoint.find(params[:id])
    @members = Member.order(:name)
  end

  def update
    @manual_points = ManualPoint.find(params[:id])
    if @manual_points.update(manual_points_params)
      flash[:notice] = 'Manual Points Updated Successfully'
      redirect_to(manual_point_path(@manual_points))
    else
      flash[:alert] = 'Manual Points Not Updated Sucessfully'
      render('edit')
    end
  end

  def delete
    @manual_points = ManualPoint.find(params[:id])
  end

  def destroy
    @manual_points = ManualPoint.find(params[:id])
    @manual_points.destroy
    flash[:notice] = 'Points Manually Deleted Successfully'
    redirect_to(manual_points_path)
  end

  def semester_transfer
    @manual_points = ManualPoint.new
    @semesters = Semester.order(:dates, desc: true)
  end

  def create_semester_transfer
    params.require(:semester_transfer).permit(:points, :from_semester_id, :to_semester_id)
    points = params[:semester_transfer][:points]
    from = params[:semester_transfer][:from_semester_id]
    to = params[:semester_transfer][:to_semester_id]
    if from == to
      flash[:alert] = 'You cannot transfer points from and to the same semester.'
      render('semester_transfer')
    end
    members = Member.all
    members.each |member| do
      mp = member.total_points
      mp = mp > points ? points : mp
      @manual_points = ManualPoint.new({})

    end
  end

  private

  def manual_points_params
    params.require(:manual_point).permit(:points, :reason, :reason_message, :member_id)
  end
end
