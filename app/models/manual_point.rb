# frozen_string_literal: true

class ManualPoint < ApplicationRecord
  belongs_to :member
  belongs_to :semester
  enum reason: { miscellaneous: 0, volunteer: 10, transfer_old: 20 }

  def self.to_csv
    attributes = %w{id member_id semester_id points reason reason_message}
 
    CSV.generate(headers: true) do |csv|
      csv << attributes
 
      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
end
