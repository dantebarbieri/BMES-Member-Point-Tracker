# frozen_string_literal: true

class AccomplishmentsMembersController < ApplicationController
  include Secured
  include ExistingUser
  include AdminSecured

  def index
    @accomplishments_members = AccomplishmentsMember.order(:accomplishment_id, :member_id)

  end

  def show
    @accomplishments_member = AccomplishmentsMember.find(params[:id])
  end

  def new
    requisite_data
    unless @semesters.any?
      flash[:alert] = 'You cannot give an accomplishment to a member without a semester.'
      redirect_to "/semesters/new"
    end
    unless @accomplishments.any?
      flash[:alert] = 'You cannot give an accomplishment to a member without an accomplishment.'
      redirect_to "/accomplishments/new"
    end
    @accomplishments_member = AccomplishmentsMember.new
  end

  def create
    new_params = accomplishments_member_params
    # new_params[:given_by] = Member.find_by_uid(session[:app_user]['uid']).id
    @accomplishments_member = AccomplishmentsMember.new(new_params)
    if @accomplishments_member.save
      flash[:notice] = "Accomplishment #{@accomplishments_member.accomplishment.name} Given To #{@accomplishments_member.member.name} Successfully"
      redirect_to(accomplishments_member_path(@accomplishments_member))
    else
      flash[:error] = 'Accomplishment not given successfully.'
      render('new')
    end
  end

  def edit
    requisite_data
    @accomplishments_member = AccomplishmentsMember.find(params[:id])
  end

  def update
    @accomplishments_member = AccomplishmentsMember.find(params[:id])
    if @accomplishments_member.update(accomplishments_member_params)
      flash[:notice] = "Accomplishment #{@accomplishments_member.accomplishment.name} Given To #{@accomplishments_member.member.name} Successfully"
      redirect_to(accomplishments_member_path(@accomplishments_member))
    else
      flash[:error] = 'Accomplishment not given successfully.'
      render('edit')
    end
  end

  def delete
    @accomplishments_member = AccomplishmentsMember.find(params[:id])
  end

  def destroy
    @accomplishments_member = AccomplishmentsMember.find(params[:id])
    @accomplishments_member.destroy
    flash[:notice] = "Accomplishment #{@accomplishments_member.accomplishment.name} Removed From #{@accomplishments_member.member.name} Successfully"
    redirect_to(accomplishments_members_path)
  end

  def download
    @accomplishments_members = AccomplishmentsMember.order(:accomplishment_id, :member_id)
    respond_to do |format|
      format.html
      format.csv { send_data @accomplishments_members.to_csv, filename: "accomplishments-#{Date.today}.csv" }
    end
  end
  private

  def accomplishments_member_params
    params.require(:accomplishments_member).permit(:accomplishment_id, :member_id, :semester_id)
  end

  def requisite_data
    @accomplishments = Accomplishment.order(:name)
    @members = Member.order(:name)
    @semesters = Semester.order(dates: :desc)
  end
end
