class AccomplishmentsController < ApplicationController
   def index
    @accomplishments = Accomplishments.all
  end

  def show
    @accomplishments = Accomplishments.find(params[:id])
  end

  def edit
    @accomplishments = Accomplishments.find(params[:id])
  end

  def update
    @accomplishments = Accomplishments.find(params[:id])
    if @accomplishments.update_attributes(accomplishments)
      flash[:notice] = "Accomplishment ${@accomplishment.name} Updated Successfully"
      redirect_to(accomplishments_path(@accomplishments))
    else
      render('edit')
    end
  end

  private
  def accomplishments
    params.require(:accomplishments).permit(:name, :description, :points)
  end
end