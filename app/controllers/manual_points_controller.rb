class ManualPointsController < ApplicationController
   def index
    @manual_points = ManualPoints.all
  end

  def show
    @manual_points = ManualPoints.find(params[:id])
  end

  def edit
    @manual_points = ManualPoints.find(params[:id])
  end

  def update
    @manual_points = ManualPoints.find(params[:id])
    if @manual_points.update_attributes(manual_points)
      flash[:notice] = "Points Manually Updated Successfully"
      redirect_to(manual_points_path(@manual_points))
    else
      render('edit')
    end
  end

  private
  def manual_points_params
    params.require(:manual_points).permit(:points, :reason)
  end
end