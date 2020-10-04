class Event < ApplicationRecord
  has_and_belongs_to_many :members
  validates :name, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :event_type, presence: true
  validates :attendance_points, numericality: true, presence: true
  enum event_type: {general: 0, mentorship: 10, socials: 20}
end
