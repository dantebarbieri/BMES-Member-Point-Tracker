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
    puts manual_points_params
    if @manual_points.update(manual_points_params)
      flash[:notice] = 'Manual Points Updated Successfully'
      redirect_to(manual_point_path(@manual_points))
    else
      flash[:error] = 'Manual Points Not Updated Sucessfully'
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

  private

  def manual_points_params
    params.require(:manual_point).permit(:points, :reason, :member_id)
  end
end
