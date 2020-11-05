# frozen_string_literal: true

class Event < ApplicationRecord
  include Filterable

  has_and_belongs_to_many :members
  validates :name, presence: true
  validates :start_time, presence: true
  validates :event_type, presence: true
  validates :attendance_points, numericality: true, presence: true
  validates :participation_tracker_id, numericality: true
  enum event_type: { general: 0, mentorship: 10, socials: 20 }

  scope :filter_by_name, ->(name) { where('lower(name) LIKE :name', name: "%#{name.downcase}%") }
  scope :filter_by_start_time, ->(start_time) { where(start_time: start_time.all_day) }
  scope :filter_by_hidden, ->(hidden) { where(hidden: hidden) }
  scope :filter_by_event_type, ->(event_type) { where(event_type: event_type) }
  scope :filter_by_attendance_points, ->(attendance_points) { where(attendance_points: attendance_points) }
  scope :filter_by_participation_tracker_id, ->(participation_tracker_id) { where(participation_tracker_id: participation_tracker_id) }

  # for future use with date ranges
  def str_to_date_range(date)
    start_date, end_date = date.split(' - ')
    start_date..end_date
  end

  def self.to_csv
   attributes = %w{name time type points id}

   CSV.generate(headers: true) do |csv|
     csv << attributes

     all.each do |user|
       csv << attributes.map{ |attr| user.send(attr) }
     end
   end
 end

end
