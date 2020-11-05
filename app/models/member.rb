# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :accomplishments_members, dependent: :destroy
  has_many :accomplishments, through: :accomplishments_members
  has_many :manual_points, dependent: :destroy
  has_and_belongs_to_many :events
  enum role: { unconfirmed: 0, member: 10, admin: 20, executive_admin: 30 }

  def is_admin?
    admin? or executive_admin?
  end

  def paid_dues?
    dues != nil
  end

  def dues(semester_date = Date.today)
    return accomplishments.find_by_id(dues_id) if semester_date.nil?

    semesters = Semester.get_semesters(semester_date)
    accomplishments_members.each do |dues|
      return dues if dues.accomplishment.is_dues && semesters.ids.include?(dues.semester_id)
    end
    nil
  end

  def attendance_points(current_semester = false)
    return events.sum(:attendance_points) unless current_semester
    puts Semester.current_semester.dates
    total = 0
    events.each do |event|
      puts event.start_time.to_date
      total += event.attendance_points if Semester.in_current_semester?(event.start_time.to_date)
    end
    total
  end

  def accomplishment_points(current_semester = false)
    return accomplishments.sum(:points) unless current_semester

    total = 0
    semester_id = Semester.current_semester.id
    accomplishments_members.each do |accomplishment_member|
      total += accomplishment_member.accomplishment.points if semester_id == accomplishment_member.semester_id
    end
    total
  end

  def manual_points_received(current_semester = false)
    return manual_points.sum(:points) unless current_semester

    total = 0
    semester_id = Semester.current_semester.id
    manual_points.each do |manual_point|
      total += manual_point.points if semester_id == manual_point.semester_id
    end
    total
  end

  def total_points(current_semester = false)
    return attendance_points + accomplishment_points + manual_points_received unless current_semester

    attendance_points(true) + accomplishment_points(true) + manual_points_received(true)
  end

  def confirmed?
    if (role == 'unconfirmed') || role.nil?
      false
    else
      true
    end
  end
end
