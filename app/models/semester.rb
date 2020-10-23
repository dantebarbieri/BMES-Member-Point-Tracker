# frozen_string_literal: true

class Semester < ApplicationRecord
  has_many :accomplishments_members
  has_many :manual_points

  def self.in_current_semester?(date = Date.today)
    Semester.current_semester.each do |semester|
      case date
      when semester.dates
        return true
      end
    end
    false
  end

  def self.current_semester
    Semester.get_semesters(Date.today)
  end

  def self.get_semesters(date)
    Semester.where('dates @> date(?)', date)
  end
end
