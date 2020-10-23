# frozen_string_literal: true

class Event < ApplicationRecord
  include Filterable

  has_and_belongs_to_many :members
  validates :name, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :event_type, presence: true
  validates :attendance_points, numericality: true, presence: true
  enum event_type: { general: 0, mentorship: 10, socials: 20 }

  scope :filter_by_name, -> (name) { where("lower(name) LIKE :name", name: "%#{name.downcase}%") }
  scope :filter_by_date, -> (date) { where(date: date) }
  scope :filter_by_time, -> (time) { where(time: time) }
  scope :filter_by_hidden, -> (hidden) { where(hidden: hidden) }
  scope :filter_by_event_type, -> (event_type) { where(event_type: event_type) }
  scope :filter_by_attendance_points, -> (attendance_points) { where(attendance_points: attendance_points) }

  # for future use with date ranges
  def str_to_date_range(date)
    start_date, end_date = date.split(' - ')
    start_date..end_date
  end

end
