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
end
