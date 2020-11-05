# frozen_string_literal: true

class Semester < ApplicationRecord
  has_many :accomplishments_members
  has_many :manual_points

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
