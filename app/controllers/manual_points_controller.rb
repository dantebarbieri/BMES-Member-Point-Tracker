# frozen_string_literal: true

class ManualPointsController < ApplicationController
  def index
    @manual_points = ManualPoints.all
  end

  def show
    @manual_points = ManualPoins.find(params[:id])
  end

  def new
    @manual_points = ManualPoints.new
  end

  def create
    @manual_points = ManualPoints.new(manual_points_params)
    if @manual_points.save
      flash[:notice] = 'Manual Points Cretaed Successfully'
      redirect_to(manual_points_path)
    else
      render('new')
    end
  end

  def edit
    @manual_points = ManualPoints.find(params[:id])
  end

  def update
    @manual_points = ManualPoints.find(params[:id])
    session[:return_to] ||= request.referer
    if @manual_points.update_attributes(manual_points_params)
      flash[:notice] = 'Manual Points Updated Successfully'
      redirect_to(manual_points_path(@manual_points))
    else
      redirect_to session.delete(:return_to)
    end
  end

  def delete
    @manual_points = ManualPoints.find(params[:id])
  end

  def destroy
    @manual_points = ManualPoints.find(params[:id])
    @manual_points.destroy
    flash[:notice] = 'Manual Points Deleted Successfully'
    redirect_to(manual_points_path)
  end

  private

  def manual_points_params
    params.require(:manual_points).permit(:points, :reason)
  end
end