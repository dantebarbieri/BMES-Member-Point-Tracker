# frozen_string_literal: true

require 'rails_helper'

describe '/' do
  it 'welcomes the user' do
    visit '/'
    expect(page).to have_content 'Welcome'
  end
end