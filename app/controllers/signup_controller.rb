# frozen_string_literal: true

class SignupController < ApplicationController
  include Secured
  include NewUser
  include NewEmail
  def new
    @member = Member.new

    @supplied_name = session[:app_user]['name']
    @supplied_email = session[:app_user]['email']
  end

  def create
    @member = Member.new(member_params)
    @member.email = session[:app_user]['email']
    @member.uid = session[:app_user]['uid']
    @member.role = :unconfirmed

    # This ensures you don't try to make a duplicate user.
    # @member_current = Member.find_by_email(@member.email)
    # if @member_current
    # @member_current.update(member_params)
    # redirect_to dashboard_path, notice: "Your user information was edited."
    # return
    # end
    if @member.email.downcase == 'MemberTrackerBMES@gmail.com'.downcase
      @member.executive_admin!
    else
      # Ensure that member has all required values.
      redirect_to controller: :signup, action: :new unless @member
    end

    if @member.save
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  private def member_params
    # Specifies that form will only take in name and class year
    params.require(:member).permit(:name, :class_year)
  end
end
