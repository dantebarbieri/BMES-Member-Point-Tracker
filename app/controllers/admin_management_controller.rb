# frozen_string_literal: true

class AdminManagementController < ApplicationController
  include Secured
  include ExistingUser
  include ExecutiveSecured

  def index
    # Show all members
    @users = Member.all
  end

  def grant
    user = Member.find(params[:id])

    name = user.name

    unless user.executive_admin?
      user.update(role: Member.roles[:admin])
      flash[:notice] = ('The member [' + name.to_str + '] was granted admin status.')
    end

    redirect_to admins_path
  end

  def show
    # Show one admin
    @user = Member.find(params[:id])
  end

  def revoke
    user = Member.find(params[:id])
    name = user.name

    unless user.executive_admin?
      user.update(role: Member.roles[:member])
      flash[:notice] = ('The member [' + name.to_str + '] had their admin status revoked.')
    end

    redirect_to admins_path
  end
end
