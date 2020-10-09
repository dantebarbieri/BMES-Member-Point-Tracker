# frozen_string_literal: true

class ProfileController < ApplicationController
  include Secured
  include ExistingUser

  def show
    #@supplied_email = session[:app_user]['email']
    #@member = Member.find_by_email(@supplied_email)

    #Need to find user by id
    @supplied_uid = session[:app_user]['uid']
    @member = Member.find_by_uid(@supplied_uid)
  end

  def edit
    #@supplied_email = session[:app_user]['email']
    #@member = Member.find_by_email(@supplied_email)

    #Need to find user by id
    @supplied_uid = session[:app_user]['uid']
    @member = Member.find_by_uid(@supplied_uid)
  end

  def update
    #@supplied_email = session[:app_user]['email']
    #@member = Member.find_by_email(@supplied_email)

    #Need to find user by id
    @supplied_uid = session[:app_user]['uid']
    @member = Member.find_by_uid(@supplied_uid)

    if @member.update(member_params)
      redirect_to profile_path, notice: 'Your data was updated.'
    else
      render 'edit'
    end
  end

  private def member_params
    params.require(:member).permit(:name, :class_year)
  end
end
