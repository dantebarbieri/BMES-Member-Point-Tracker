class AccomplishmentsController < ApplicationController
  include Secured
  include ExistingUser
  include AdminSecured

  def index
    @accomplishments = Accomplishment.all
  end

  def new
    @accomplishment = Accomplishment.new
  end

  def create
    @accomplishment = Accomplishment.new(accomplishments_params)
    if @accomplishment.save
      flash[:notice] = "Accomplishment #{@accomplishment.name} Created Successfully"
      redirect_to(accomplishments_path(@accomplishment))
    else
      render('new')
    end
  end

  def edit
    @accomplishment = Accomplishment.find(params[:id])
  end

  def update
    @accomplishment = Accomplishment.find(params[:id])
    session[:return_to] ||= request.referer
    if @accomplishment.update_attributes(accomplishments_params)
      flash[:notice] = "Accomplishment #{@accomplishment.name} Updated Successfully"
      redirect_to(accomplishments_path(@accomplishment))
    else
      redirect_to session.delete(:return_to)
    end
  end

  def delete
    @accomplishment = Accomplishment.find(params[:id])
  end

  def destroy
    @accomplishment = Accomplishment.find(params[:id])
    @accomplishment.destroy
    flash[:notice] = "Accomplishment #{@accomplishment.name} Destroyed Successfully"
    redirect_to(accomplishments_path)
  end

  def show
    @accomplishment = Accomplishment.find(params[:id])
  end

  private
	
  def accomplishments_params
    params.require(:accomplishment).permit(:name, :description, :points)
  end
end
