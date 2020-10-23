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
    @semesters = Semester.order(dates: :desc)
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
    @semesters = Semester.order(dates: :desc)
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
    @semesters = Semester.order(dates: :desc)
  end

  def create_semester_transfer
    params.require(:semester_transfer).permit(:points, :from_semester_id, :to_semester_id)
    points = BigDecimal(params[:semester_transfer][:points])
    from = params[:semester_transfer][:from_semester_id]
    to = params[:semester_transfer][:to_semester_id]
    if from == to
      flash[:alert] = 'You cannot transfer points from and to the same semester.'
      @manual_points = ManualPoint.new
      @semesters = Semester.order(dates: :desc)
      redirect_to(manual_points_path)
    else
      members = Member.all
      members.each do |member|
        if member.manual_points.where(reason_message: transfer_reason(from, to)).empty?
          mp = member.total_points
          mp = mp > points ? points : mp
          @manual_points = ManualPoint.new(points: mp, reason: 'transfer_old', reason_message: transfer_reason(from, to), member_id: member.id, semester_id: to)
          if @manual_points.save
            flash[:notice] = 'Points Manually Created Successfully'
          else
            flash[:notice] = ''
            flash[:alert] = "An unexpected error occurred transfering points for #{member.name} (#{member.email})."
            @manual_points = ManualPoint.new
            @semesters = Semester.order(dates: :desc)
            redirect_to(manual_points_path)
            return nil
          end
        end
      end
      flash[:notice] = "Points successfully transferred from #{Semester.find_by_id(from).name} to #{Semester.find_by_id(to).name}"
      redirect_to(manual_points_path)
    end
  end

  def delete_semester_transfer
    @manual_points = ManualPoint.new
    @semesters = Semester.order(dates: :desc)
  end

  def redirect_confirm_delete_semester_transfer
    redirect_to("/manual_points/confirm_delete_semester_transfer/#{params[:semester_transfer][:from_semester_id]}/#{params[:semester_transfer][:to_semester_id]}")
  end

  def confirm_delete_semester_transfer
    from = params[:from]
    to = params[:to]
    @from = Semester.find_by_id(from)
    @to = Semester.find_by_id(to)
    @manual_points = ManualPoint.where(reason_message: transfer_reason(from, to))
    if @manual_points.empty?
      flash[:alert] = "There are no known semester transfers from #{@from.name} to #{@to.name}"
      @manual_points = ManualPoint.new
      @semesters = Semester.order(dates: :desc)
      render('delete_semester_transfer')
    end
  end

  def destroy_semester_transfer
    from = params[:from]
    to = params[:to]
    @manual_points = ManualPoint.where(reason_message: transfer_reason(from, to))
    @manual_points.each do |manual_point|
      manual_point.destroy
    end
    flash[:notice] = "Transfer points successfully deleted from #{Semester.find_by_id(from).name} to #{Semester.find_by_id(to).name}"
    redirect_to(manual_points_path)

  private

  def manual_points_params
    params.require(:manual_point).permit(:points, :reason, :reason_message, :member_id, :semester_id)
  end

  def transfer_reason(from_id, to_id)
    "DO NOT EDIT THIS: FROM SEMESTER ID: #{from_id} TO SEMESTER ID: #{to_id}."
  end
end
