# frozen_string_literal: true

# This spec tests to ensure non-logged in users
# are pushed away from protected pages.
require 'rails_helper'

describe '/events requires login' do
  it 'Denies access to events' do
    visit '/events'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/semesters requires login' do
  it 'Denies access to semesters' do
    visit '/semesters'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/manual_points requires login' do
  it 'Denies access to manual_points' do
    visit '/manual_points'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/accomplishments requires login' do
  it 'Denies access to accomplishments' do
    visit '/accomplishments'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/accomplishments_members requires login' do
  it 'Denies access to accomplishments_members' do
    visit '/accomplishments_members'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/dashboard requires login' do
  it 'Denies access to dashboard' do
    visit '/dashboard'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/signup requires login' do
  it 'Denies access to signup' do
    visit '/signup'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/profile requires login' do
  it 'Denies access to profile' do
    visit '/profile'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/edit requires login' do
  it 'Denies access to edit' do
    visit '/edit'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/points requires login' do
  it 'Denies access to points' do
    visit '/points'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/members requires login' do
  it 'Denies access to members' do
    visit '/members'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/members/i requires login' do
  it 'Denies access to members/i' do
    visit '/members/1'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/admins requires login' do
  it 'Denies access to admins' do
    visit '/admins'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/admins/i requires login' do
  it 'Denies access to admins/i' do
    visit '/admins/1'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/accomplishments_members/index requires login' do
  it 'Denies access to /accomplishments_members/index' do
    visit '/accomplishments_members/index'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/accomplishments_members/show requires login' do
  it 'Denies access to /accomplishments_members/show' do
    visit '/accomplishments_members/show'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/accomplishments_members/new requires login' do
  it 'Denies access to /accomplishments_members/new' do
    visit '/accomplishments_members/new'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/accomplishments_members/edit requires login' do
  it 'Denies access to /accomplishments_members/edit' do
    visit '/accomplishments_members/edit'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/accomplishments_members/delete requires login' do
  it 'Denies access to /accomplishments_members/delete' do
    visit '/accomplishments_members/delete'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/upcoming_events requires login' do
  it 'Denies access to /upcoming_events' do
    visit '/upcoming_events'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end

describe '/upcoming_events/show requires login' do
  it 'Denies access to /upcoming_events/show' do
    visit '/upcoming_events/show'
    expect(page).to have_content 'You must log in to access the selected feature.'
  end
end
