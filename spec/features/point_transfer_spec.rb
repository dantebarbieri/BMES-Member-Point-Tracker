# This spec tests to ensure semesters point transfers can occur
require 'rails_helper'


describe 'Semester Point Transfer Features' do
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

  it 'Can visit the point transfer feature' do
    visit '/manual_points'
    click_on 'Transfer Points Between Semester'
    expect(page).to have_content 'New Semester Transfer Points'
  end

  it 'Can visit undo transfer feature' do
    visit '/manual_points'
    click_on 'Undo Transfer Points Between Semester'
    expect(page).to have_content 'Delete Semester Transfer Points'
  end


end