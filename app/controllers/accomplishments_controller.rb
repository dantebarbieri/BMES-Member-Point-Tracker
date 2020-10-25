# frozen_string_literal: true

class AccomplishmentsController < ApplicationController
  include Secured
  include ExistingUser
  include AdminSecured

  def index
    @accomplishments = Accomplishment.order(is_dues: :desc, name: :asc)
  end

  def new
    @accomplishments = Accomplishment.new
  end

  def create
    @accomplishments = Accomplishment.new(accomplishments_params)
    if @accomplishments.save
      flash[:notice] = "Accomplishment #{@accomplishments.name} Created Successfully"
      redirect_to(accomplishments_path(@accomplishments))
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
      flash[:notice] = "Accomplishment #{@accomplishments.name} Updated Successfully"
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
    flash[:notice] = "Accomplishment #{@accomplishments.name} Destroyed Successfully"
    redirect_to(accomplishments_path)
  end

  def show
    @accomplishments = Accomplishment.find(params[:id])
  end

  private

  def accomplishments_params
    params.require(:accomplishment).permit(:name, :description, :points, :is_dues)
  end
end
