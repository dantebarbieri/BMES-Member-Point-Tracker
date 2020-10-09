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
