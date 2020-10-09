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
  
	def dues(semester_date = Date.today)
	  return accomplishments.find_by_id(dues_id) if semester_date.nil?
  
	  semesters = Semester.get_semesters(semester_date)
		accomplishments_members.each do |dues|
		return dues if dues.accomplishment.is_dues and semesters.ids.include? dues.semester_id
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
		semesters = []
		Semester.current_semester.each do |semester|
			semesters << semester.id
		end
	  accomplishments_members.each do |accomplishment_member|
		total += accomplishment_member.accomplishment.points if semesters.include? accomplishment_member.semester_id
	  end
	  total
	end
  
	def manual_points_received(current_semester = false)
	  return manual_points.sum(:points) unless current_semester
  
	  total = 0
	  manual_points.each do |manual_points|
		total += manual_points.points if Semester.in_current_semester?(manual_points.created_at)
	  end
	  total
	end
  
	def total_points(current_semester = false)
	  return attendance_points + accomplishment_points + manual_points_received unless current_semester
  
	  attendance_points(true) + accomplishment_points(true) + manual_points_received(true)
	end

	def confirmed?
		if role == 'unconfirmed' or role == nil
			return false
		else
			return true
		end
	end
end
  
