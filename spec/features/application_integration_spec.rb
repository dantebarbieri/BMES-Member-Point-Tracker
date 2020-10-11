# frozen_string_literal: true

require 'rails_helper'

describe '/' do
  it 'welcomes the user' do
    visit '/'
    expect(page).to have_content 'Welcome'
  end

  it 'has a log in button' do
    visit '/'
    expect(page).to have_content 'Log In'
  end
end

describe 'navigation' do
  before :each do
    @member = Member.create(name: 'Test Member',
      email: 'test_member@mail.com',
      class_year: '1970',
      role: 'member',
      uid: 'BAAB00')
    get :home, params: nil, session: {userinfo: {present: true}, app_user: {name: @member.name, email: @member.email, uid: @member.uid, kicked_out: false}} # Fake userinfo for Secured concern
  end

  it 'has a dashboard button' do
    visit '/'
    expect(page).to have_link 'Dashboard'
  end

  it 'redirects to /dashboard when the dashboard button is clicked' do
    visit '/'
    click_link 'Dashboard'
    expect(page).to have_current_path '/dashboard'
  end

  it 'has a profile button' do
    visit '/'
    expect(page).to have_link 'Profile'
  end

  it 'redirects to /profile when the dashboard profile is clicked' do
    visit '/'
    click_link 'Profile'
    expect(page).to have_current_path '/profile'
  end

  it 'has an Upcoming Events button' do
    visit '/'
    expect(page).to have_link 'Upcoming Events'
  end

  it 'redirects to /upcoming_events when the Upcoming Events button is clicked' do
    visit '/'
    click_link 'Upcoming Events'
    expect(page).to have_current_path '/upcoming_events'
  end

  it 'has a log out button' do
    visit '/'
    expect(page).to have_link 'Log Out'
  end

  it 'logs the user out when the log out button is clicked' do
    visit '/'
    click_link 'Log Out'
    expect(page).to have_current_path '/'
    expect(page).to have_content 'You have been logged out.'
  end
end
