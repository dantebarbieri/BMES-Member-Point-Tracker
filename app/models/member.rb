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
    total = 0
    events.where(start_time: Semester.current_semester.dates).each do |event|
      puts event.start_time.to_date
      total += event.attendance_points
    end
    total
  end

  def attendance_points_in(semester_id)
    semester = Semester.find_by_id(semester_id)
    puts semester.name
    puts semester.dates
    total = 0
    events.where(start_time: semester.dates).each do |event|
      puts event.start_time
      total += event.attendance_points
    end
    total
  end

  def accomplishment_points(current_semester = false)
    return accomplishments.sum(:points) unless current_semester

    total = 0
    semester_id = Semester.current_semester.id
    accomplishments_members.where(semester_id: semester_id).each do |accomplishment_member|
      total += accomplishment_member.accomplishment.points
    end
    total
  end

  def accomplishment_points_in(semester_id)
    total = 0
    accomplishments_members.where(semester_id: semester_id).each do |accomplishment_member|
      puts accomplishment_member.accomplishment.name
      total += accomplishment_member.accomplishment.points
    end
    total
  end

  def manual_points_received(current_semester = false)
    return manual_points.sum(:points) unless current_semester

    total = 0
    semester_id = Semester.current_semester.id
    manual_points.where(semester_id: semester_id).each do |manual_point|
      total += manual_point.points
    end
    total
  end

  def manual_points_received_in(semester_id)
    total = 0
    manual_points.where(semester_id: semester_id).each do |manual_point|
      total += manual_point.points
    end
    total
  end

  def total_points(current_semester = false)
    return attendance_points + accomplishment_points + manual_points_received unless current_semester

    attendance_points(true) + accomplishment_points(true) + manual_points_received(true)
  end

  def total_points_in(semester_id)
    attendance_points_in(semester_id) + accomplishment_points_in(semester_id) + manual_points_received_in(semester_id)
  end

  def confirmed?
    if (role == 'unconfirmed') || role.nil?
      false
    else
      true
    end
  end

  def self.to_csv
    attributes = %w{id name email class_year role}
    headers = %w{id name email class_year role points_this_semester total_points}
 
    CSV.generate(headers: true) do |csv|
      csv << headers
 
      all.each do |user|
        csv << (attributes.map{ |attr| user.send(attr) } << user.total_points(true) << user.total_points)
      end
    end
  end

  def self.to_attendance_csv
    attributes = %w{event_id participation_tracker_id}
    headers = %w{member_id event_id participation_tracker_event_id}
 
    CSV.generate(headers: true) do |csv|
      csv << headers
 
      all.each do |user|
        user.events.each do |event|
          csv << [user.id, event.id, event.participation_tracker_id]
        end
      end
    end
  end
end
