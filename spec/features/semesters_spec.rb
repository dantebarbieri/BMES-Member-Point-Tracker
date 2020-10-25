# This spec tests to ensure semesters can be created and deleted
require 'rails_helper'


describe 'Semester CRUD Features' do
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


  it 'Can access the Semesters page as admin' do
    visit '/semesters'
    expect(page).to have_content 'Semesters Page'
  end

  it 'Can create a new semester' do
    visit '/semesters'
    click_on 'New Semester'
    fill_in 'semester_name', with: 'Fall 2021'
    fill_in 'semester_start', with: '08/20/2021'
    fill_in 'semester_end', with: '12/15/2021'
    click_on 'Create Semester'
    expect(page).to have_content 'added successfully.'
  end

  it 'Can delete a newly created semester' do
    visit '/semesters'
    click_on 'New Semester'
    fill_in 'semester_name', with: 'Fall 2021'
    fill_in 'semester_start', with: '08/20/2021'
    fill_in 'semester_end', with: '12/15/2021'
    click_on 'Create Semester'
    visit '/semesters'
    click_on(class: 'fa fa-trash fa-lg')
    click_on 'Delete Semester'
    expect(page).to have_content 'destroyed successfully.'
  end

end