# frozen_string_literal: true

# This spec tests to ensure user profiles can be edited
require 'rails_helper'

describe 'Profile Edit Features' do
  before :each do
    user = { 'name' => 'New Admin', 'email' => 'admin@user.com', 'uid' => 'user|3', 'kicked_out' => false }
    page.set_rack_session(userinfo: user)
    page.set_rack_session(app_user: user)

    member = Member.new
    member.name = 'New Admin'
    member.email = 'admin@user.com'
    member.uid = 'user|3'
    member.role = 20

    member.save
  end

  it 'Can view and edit profile information' do
    visit '/profile'
    click_on 'Edit Profile'
    fill_in 'member_name', with: 'NewName'
    fill_in 'member_class_year', with: '2030'
    click_on 'Save Member'
    expect(page).to have_content 'NewName'
  end
end
