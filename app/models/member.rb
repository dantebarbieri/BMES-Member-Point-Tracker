# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :accomplishments_members
  has_many :accomplishments, through: :accomplishments_members
  has_many :manual_points
  has_and_belongs_to_many :events
  enum role: { unconfirmed: 0, member: 10, admin: 20, executive_admin: 30 }

  def is_admin?
    admin? or executive_admin?
  end

  def paid_dues?
    dues != nil
  end

  def dues(dues_id = 1, semester_date = Date.today)
    return accomplishments.find_by_id(dues_id) if semester_date.nil?

    semesters = Semester.get_semesters(semester_date)
    accomplishments_members.where(accomplishment_id: dues_id).each do |dues|
      return dues if semesters.ids.include? dues.semester_id
    end
    nil
  end

  def attendance_points(current_semester = false)
    return events.sum(:attendance_points) unless current_semester

    total = 0
    events.each do |event|
      total += event.attendance_points if Semester.in_current_semester?(event.date)
    end
    total
  end

  def accomplishment_points(current_semester = false)
    return accomplishments.sum(:points) unless current_semester

    total = 0
    accomplishments.each do |accomplishment|
      total += accomplishment.points if Semester.in_current_semester?(accomplishment.date)
    end
    total
  end

  def manual_points_received(current_semester = false)
    return manual_points.sum(:points) unless current_semester

    total = 0
    accomplishments.each do |accomplishment|
      total += accomplishment.points if Semester.in_current_semester?(accomplishment.date)
    end
    total
  end

  def total_points(current_semester = false)
    return attendance_points + accomplishment_points + manual_points_received unless current_semester

    attendance_points(true) + accomplishment_points(true) + manual_points_received(true)
  end
end
