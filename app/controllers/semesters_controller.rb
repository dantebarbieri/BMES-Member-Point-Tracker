# frozen_string_literal: true

class SemestersController < ApplicationController
  include Secured
  include ExistingUser
  include AdminSecured

  def index
    @semesters = Semester.order(:dates)
  end

  def show
    @semester = Semester.find(params[:id])
  end

  def edit
    @semester = Semester.find(params[:id])
  end

  def update
    sem_params = semester_params[:semester]
    @semester = Semester.find(params[:id])
    if @semester.update_attributes({ name: sem_params[:name], dates: Date.parse(sem_params[:start])..Date.parse(sem_params[:end]) })
      flash[:notice] = "Semester '#{@semester.name}' updated successfully."
      redirect_to(semesters_path)
    else
      flash[:error] = 'Semester was not updated successfully.'
      render('edit')
    end
  end

  def delete
    @semester = Semester.find(params[:id])
  end

  def destroy
    @semester = Semester.find(params[:id])
    @semester.destroy
    flash[:notice] = "Semester '#{@semester.name}' destroyed successfully."
    redirect_to(semesters_path)
  end

  def new
    @semester = Semester.new
  end

  def create
    sem_params = semester_params
    puts sem_params
    @semester = Semester.new({ name: sem_params[:name], dates: Date.parse(sem_params[:start])..Date.parse(sem_params[:end]) })
    if @semester.save
      flash[:notice] = "Semester '#{@semester.name}' added successfully."
      redirect_to(semester_path(@semester))
    else
      flash[:error] = 'Semester was not added successfully.'
      render('new')
    end
  end

  def download
    @semesters = Semester.order(:dates)
    respond_to do |format|
      format.html
      format.csv { send_data @semesters.to_csv, filename: "semesters-#{Date.today}.csv" }
    end
  end

  private

  def semester_params
    params.require(:semester).permit(:name, :start, :end)
  end
end
