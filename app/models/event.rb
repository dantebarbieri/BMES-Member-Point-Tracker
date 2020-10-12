# frozen_string_literal: true

class Event < ApplicationRecord
  has_and_belongs_to_many :members
  validates :name, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :event_type, presence: true
  validates :attendance_points, numericality: true, presence: true
  enum event_type: { general: 0, mentorship: 10, socials: 20 }

  def self.search(params)
    if validate_search params
      where("lower(name) LIKE :name", name: "%#{params[:name].downcase}%")
    else
      Event.all
    end
  end
  
  # Quick and dirty check TODO improve
  def self.validate_search(params)
    params[:name].present? or 
    params[:date].present? or 
    params[:time].present? or
    params[:hidden].present? or 
    params[:event_type].present? or 
    params[:attendance_points].present?
  end
end
