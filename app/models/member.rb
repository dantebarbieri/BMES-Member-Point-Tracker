class Member < ApplicationRecord
	has_many :accomplishments_members
	has_many :accomplishments, :through => :accomplishments_members
	has_many :manual_points
	has_and_belongs_to_many :events

	def paid_dues?
		self.dues != nil
	end

	def dues(dues_id = 1)
		self.accomplishments.find_by_id(dues_id)
	end

	def attendance_points
		self.events.sum(:attendance_points)
	end

	def accomplishment_points
		self.accomplishments.sum(:points)
	end

	def manual_points_received
		self.manual_points.sum(:points)
	end

	def total_points
		self.attendance_points + self.accomplishment_points + self.manual_points_received
	end
end
