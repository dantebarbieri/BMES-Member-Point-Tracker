# frozen_string_literal: true

class Accomplishment < ApplicationRecord
  has_many :accomplishments_members, dependent: :destroy
  has_many :members, through: :accomplishments_members

  def self.to_csv
    attributes = %w[id name description points is_dues]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map { |attr| user.send(attr) }
      end
    end
  end
end
