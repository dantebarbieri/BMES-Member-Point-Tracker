# frozen_string_literal: true

class ChangeEventStartTime < ActiveRecord::Migration[6.0]
  def up
    add_column :events, :start_time, :datetime

    Event.all.each do |event|
      event.update start_time: event.time.change(year: event.date.year, month: event.date.month, day: event.date.day).to_datetime
    end

    change_column :events, :start_time, :datetime, null: false

    remove_column :events, :date
    remove_column :events, :time
  end

  def down
    # puts ":down"
    add_column :events, :date, :date
    add_column :events, :time, :time

    Event.all.each do |event|
      event.update date: event.start_time.to_date, time: event.start_time.to_time
    end

    remove_column :events, :start_time, :datetime
  end
end
