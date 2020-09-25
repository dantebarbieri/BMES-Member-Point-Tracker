class ManualPointsController < ApplicationController
  include Secured
  include ExistingUser
  include AdminSecured

  def index
    @manual_points = ManualPoints.all
  end

  def show
    @manual_points = ManualPoints.find(params[:id])
  end

  def new
    @manual_points = ManualPoints.new
  end

  def create
    @manual_points = ManualPoints.new(manual_points_params)
    if @manual_points.save
      flash[:notice] = "Points Manually Created Successfully"
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
      flash[:notice] = "Points Manually Updated Successfully"
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
    flash[:notice] = "Points Manually Deleted Successfully"
    redirect_to(manual_points_path)
  end

  private
  def accomplishments_params
    params.require(:manual_points).permit(:points, :reason)
  end
end