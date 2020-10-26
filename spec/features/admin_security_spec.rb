# This spec tests to ensure non-admin users
# are pushed away from protected pages. 
require 'rails_helper'


describe 'Admin Pages are Protected' do
  before :each do
    user = {'name' => 'New Member', 'email' => 'member@user.com', 'uid' => 'user|2', 'kicked_out' => false}
    page.set_rack_session(userinfo: user)
    page.set_rack_session(app_user: user)

    member = Member.new
    member.name = 'New Member'
    member.email = 'member@user.com'
    member.uid = 'user|2'
    member.role = 10

    member.save
  end

  it 'Denies access to events' do
    visit '/events'
    expect(page).to have_content 'You are not an admin.'
  end


  it 'Denies access to semesters' do
    visit '/semesters'
    expect(page).to have_content 'You are not an admin.'
  end



  it 'Denies access to manual_points' do
    visit '/manual_points'
    expect(page).to have_content 'You are not an admin.'
  end


  it 'Denies access to accomplishments' do
    visit '/accomplishments'
    expect(page).to have_content 'You are not an admin.'
  end

  it 'Denies access to accomplishments_members' do
    visit '/accomplishments_members'
    expect(page).to have_content 'You are not an admin.'
  end



  it 'Denies access to members' do
    visit '/members'
    expect(page).to have_content 'You are not an admin.'
  end

  it 'Denies access to members/i' do
    visit '/members/1'
    expect(page).to have_content 'You are not an admin.'
  end

  it 'Denies access to admins' do
    visit '/admins'
    expect(page).to have_content 'You are not an admin.'
  end


  it 'Denies access to admins/i' do
    visit '/admins/1'
    expect(page).to have_content 'You are not an admin.'
  end

  it 'Denies access to /accomplishments_members/index' do
    visit '/accomplishments_members/index'
    expect(page).to have_content 'You are not an admin.'
  end

  it 'Denies access to /accomplishments_members/show' do
    visit '/accomplishments_members/show'
    expect(page).to have_content 'You are not an admin.'
  end

  it 'Denies access to /accomplishments_members/new' do
    visit '/accomplishments_members/new'
    expect(page).to have_content 'You are not an admin.'
  end

  it 'Denies access to /accomplishments_members/edit' do
    visit '/accomplishments_members/edit'
    expect(page).to have_content 'You are not an admin.'
  end

  it 'Denies access to /accomplishments_members/delete' do
    visit '/accomplishments_members/delete'
    expect(page).to have_content 'You are not an admin.'
  end
end

describe 'Admin Pages Allow Access to Admins' do
  before :each do
    user = {'name' => 'New Admin', 'email' => 'admin@user.com', 'uid' => 'user|3', 'kicked_out' => false}
    page.set_rack_session(userinfo: user)
    page.set_rack_session(app_user: user)

    member = Member.new
    member.name = 'New Admin'
    member.email = 'admin@user.com'
    member.uid = 'user|3'
    member.role = 20

    member.save
  end

  it 'Allows access to events' do
    visit '/events'
    expect(page).to have_content 'Events'
  end


  it 'Allows access to semesters' do
    visit '/semesters'
    expect(page).to have_content 'Semesters Page'
  end



  it 'Allows access to manual_points' do
    visit '/manual_points'
    expect(page).to have_content 'Manual Points'
  end


  it 'Allows access to accomplishments' do
    visit '/accomplishments'
    expect(page).to have_content 'Accomplishments'
  end

  it 'Allows access to accomplishments_members' do
    visit '/accomplishments_members'
    expect(page).to have_content 'Accomplishments Given to Members'
  end



  it 'Allows access to members' do
    visit '/members'
    expect(page).to have_content 'User Management'
  end


  it 'Allows access to /accomplishments_members/new' do
    visit '/accomplishments_members/new'
    expect(page).to have_content 'Assign New Accomplishment to Member'
  end

end