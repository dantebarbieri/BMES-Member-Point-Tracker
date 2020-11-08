# frozen_string_literal: true

class Semester < ApplicationRecord
  has_many :accomplishments_members, dependent: :destroy
  has_many :manual_points, dependent: :destroy

  def self.in_current_semester?(date = Date.today)
    Semester.current_semester.dates.include?(date)
  end

  def self.current_semester
    Semester.get_semesters(Date.today).first
  end

  def self.get_semesters(date)
    Semester.where('dates @> date(?)', date)
  end

  def self.to_csv
    attributes = %w{id name dates}
 
    CSV.generate(headers: true) do |csv|
      csv << attributes
 
      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
end
