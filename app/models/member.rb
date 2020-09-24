class Member < ApplicationRecord
	has_many :accomplishments_members
	has_many :accomplishments, :through => :accomplishments_members
	has_many :manual_points
	has_and_belongs_to_many :events
	has_one :administrator

	def is_admin?
		return self.administrator != nil
	end

	def paid_dues?
		self.dues != nil
	end

	def dues(dues_id = 1, semester_date = Date.today)
		if semester_date == nil
			return self.accomplishments.find_by_id(dues_id)
		end
		semesters = Semester.get_semesters(semester_date)
		self.accomplishments_members.where(:accomplishment_id => dues_id).each do |dues|
			if semesters.ids.include? dues.semester_id
				return dues
			end
		end
		return nil;
	end

	def attendance_points(current_semester = false)
		unless current_semester
			return self.events.sum(:attendance_points)
		end
		total = 0
		self.events.each do |event|
			if Semester.in_current_semester?(event.date)
				total += event.attendance_points
			end
		end
		return total
	end

	def accomplishment_points(current_semester = false)
		unless current_semester
			return self.accomplishments.sum(:points)
		end
		total = 0
		self.accomplishments.each do |accomplishment|
			if Semester.in_current_semester?(accomplishment.date)
				total += accomplishment.points
			end
		end
		return total
	end

	def manual_points_received(current_semester = false)
		unless current_semester
			return self.manual_points.sum(:points)
		end
		total = 0
		self.accomplishments.each do |accomplishment|
			if Semester.in_current_semester?(accomplishment.date)
				total += accomplishment.points
			end
		end
		return total
	end

	def total_points(current_semester = false)
		unless current_semester
			return self.attendance_points + self.accomplishment_points + self.manual_points_received
		end
		return self.attendance_points(true) + self.accomplishment_points(true) + self.manual_points_received(true)
	end
end
