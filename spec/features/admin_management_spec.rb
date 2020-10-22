require 'rails_helper'

describe 'Execs can grant and revoke admin privileges' do
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

  it 'Can Grant Admin Privileges' do
  	new_member = Member.new
  	new_member.name = 'Potential Admin'
  	new_member.email = 'potential@user.com'
  	new_member.uid = 'user|5'
  	new_member.role = 10
  	new_member.save

    visit '/admins'
    click_on('Grant Admin')
    expect(page).to have_content 'Revoke Admin'
  end

  it 'Can Revoke Admin Privileges' do
  	new_member = Member.new
  	new_member.name = 'Admin'
  	new_member.email = 'admin@user.com'
  	new_member.uid = 'user|6'
  	new_member.role = 20
  	new_member.save

  	visit '/admins'

  	click_on('Revoke Admin')
  	expect(page).to have_content 'Grant Admin'
  end

end