# frozen_string_literal: true

# This spec tests to ensure events can be created and deleted
require 'rails_helper'

describe 'Events CRUD Features' do
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

  it 'Can create and delete events' do
    visit '/semesters'
    click_on 'New Semester'
    fill_in 'semester_name', with: 'Fall 2021'
    fill_in 'semester_start', with: '08/20/2021'
    fill_in 'semester_end', with: '12/15/2021'
    click_on 'Create Semester'

    visit('/events')
    click_on('Add New Event')
    fill_in 'event_name', with: 'Event Name'
    click_on('Create Event')
    click_on(class: 'fa fa-trash fa-lg')
    click_on('Delete Event')
    expect(page).to have_content 'Event Destroyed Successfully'
  end
end
