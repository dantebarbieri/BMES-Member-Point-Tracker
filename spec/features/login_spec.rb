require 'spec_helper'

feature "Signup" do

  scenario "logged in user can access signup page" do
    user = {'name' => 'New User', 'email' => 'new@user.com', 'uid' => 'user|1', 'kicked_out' => false}
    page.set_rack_session(userinfo: user)
    page.set_rack_session(app_user: user)
    visit '/dashboard'
    #visit "/signup"
    expect(page).to have_content("You still need to sign up!")
  end

  scenario "Logged in user can fill out signup form." do
    user = {'name' => 'New User', 'email' => 'new@user.com', 'uid' => 'user|1', 'kicked_out' => false}
    page.set_rack_session(userinfo: user)
    page.set_rack_session(app_user: user)

    visit '/dashboard'

    fill_in 'member_name', with: 'New User Name'
    click_on 'Save Member'
    expect(page).to have_content("Welcome, New User Name")
  end

end