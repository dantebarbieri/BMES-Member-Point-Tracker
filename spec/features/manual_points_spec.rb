# This spec tests to ensure manual points can be created and deleted
require 'rails_helper'


describe 'Manual Points CRUD Features' do
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

  it 'Can create and delete manual points' do
    visit '/semesters'
    click_on 'New Semester'
    fill_in 'semester_name', with: 'Fall 2021'
    fill_in 'semester_start', with: '08/20/2021'
    fill_in 'semester_end', with: '12/15/2021'
    click_on 'Create Semester'

    visit('/manual_points')
    click_on('Add New Manual Points')
    fill_in 'manual_point_points', with: '20.0'
    fill_in 'manual_point_reason_message', with: 'REASON MESSAGE'
    click_on('Create Manual Points')
    click_on(class: 'fa fa-trash fa-lg')
    click_on('Delete Manual Points')
    expect(page).to have_content 'Points Manually Deleted Successfully'
  end

end