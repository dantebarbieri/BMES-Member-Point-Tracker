# This spec tests to ensure non-exec users
# are pushed away from protected pages. 
require 'rails_helper'


describe 'Exec Pages are Protected' do
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


  it 'Denies access to admins' do
    visit '/admins'
    expect(page).to have_content 'You are not an executive.'
  end


  it 'Denies access to admins/i' do
    visit '/admins/1'
    expect(page).to have_content 'You are not an executive.'
  end

end

describe 'Exec Pages allow Execs' do
  before :each do
    user = {'name' => 'New Exec', 'email' => 'exec@user.com', 'uid' => 'user|4', 'kicked_out' => false}
    page.set_rack_session(userinfo: user)
    page.set_rack_session(app_user: user)

    member = Member.new
    member.name = 'New Exec'
    member.email = 'exec@user.com'
    member.uid = 'user|4'
    member.role = 30

    member.save
  end


  it 'Allows access to admins' do
    visit '/admins'
    expect(page).to have_content 'Admin Management'
  end


  it 'Allows access to admins/i' do
    visit '/admins/1'
    expect(page).to have_content 'Admin Details'
  end

end