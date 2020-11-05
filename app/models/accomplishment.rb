# frozen_string_literal: true

class Accomplishment < ApplicationRecord
  has_many :accomplishments_members, dependent: :destroy
  has_many :members, through: :accomplishments_members
end
