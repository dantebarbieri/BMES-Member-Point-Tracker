# frozen_string_literal: true

class AccomplishmentsMember < ApplicationRecord
  belongs_to :member
  belongs_to :accomplishment
  belongs_to :semester
  def self.to_csv
    attributes = %w[id member_id accomplishment_id semester_id]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map { |attr| user.send(attr) }
      end
    end
  end
end
