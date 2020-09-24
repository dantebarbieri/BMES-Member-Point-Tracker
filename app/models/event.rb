class Event < ApplicationRecord
	has_and_belongs_to_many :members
	validates presence of :name
	validates presence of :date
	validates presence of :time
	validates presence of :event_type
	validates presence of :attendance_points
	validate :event_date_cannot_be_in_the_past
  def event_date_cannot_be_in_the_past
    if :date.present? && :date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
