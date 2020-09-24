class AccomplishmentsController < ApplicationController
  def index
    @accomplishments = Accomplishment.all
  end

  def show
    @accomplishments = Accomplishment.find(params[:id])
  end

  def new
    @accomplishments = Accomplishment.new
  end

  def create
    @accomplishments = Accomplishment.new(accomplishments_params)
    if @accomplishments.save
      flash[:notice] = "Accomplishment #{@accomplishment.name} Created Successfully"
      redirect_to(accomplishments_path)
    else
      render('new')
    end
  end

  def edit
    @accomplishments = Accomplishment.find(params[:id])
  end

  def update
    @accomplishments = Accomplishment.find(params[:id])
    session[:return_to] ||= request.referer
    if @accomplishments.update_attributes(accomplishments_params)
      flash[:notice] = "Accomplishment #{@accomplishment.name} Updated Successfully"
      redirect_to(accomplishments_path(@accomplishments))
    else
      redirect_to session.delete(:return_to)
    end
  end

  def delete
    @accomplishments = Accomplishment.find(params[:id])
  end

  def destroy
    @accomplishments = Accomplishment.find(params[:id])
    @accomplishments.destroy
    flash[:notice] = "Accomplishment #{@accomplishment.name} Destroyed Successfully"
    redirect_to(accomplishments_path)
  end

  private
  def accomplishments_params
    params.require(:accomplishments).permit(:name, :description, :points)
  end
end