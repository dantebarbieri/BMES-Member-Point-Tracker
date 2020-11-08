# frozen_string_literal: true

class MemberManagementController < ApplicationController
  include Secured
  include ExistingUser
  include AdminSecured

  def index
    # Show all members
    @users = Member.all
  end

  def show
    # Show one member
    @user = Member.find(params[:id])
  end

  def show_manual_points
    @member = Member.find(params[:id])
  end

  def show_event_attendance
    @member = Member.find(params[:id])
  end

  def show_accomplishments
    @member = Member.find(params[:id])
  end

  def confirm
    user = Member.find(params[:id])
    name = user.name

    user.update(role: Member.roles[:member]) unless user.confirmed?

    redirect_to members_path, notice: ('The member [' + name.to_str + '] is confirmed into the club!')
  end

  def delete
    user = Member.find(params[:id])
    name = user.name

    # This should delete the user and then redirect back to index
    user.destroy

    redirect_to members_path, alert: ('The member [' + name.to_str + '] was deleted.')
  end

  def download
    @users = Member.all
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def download_attendance
    @users = Member.all
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_attendance_csv, filename: "users-#{Date.today}.csv" }
    end
  end
end
