# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_201_004_155_020) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'accomplishments', force: :cascade do |t|
    t.text 'name'
    t.text 'description'
    t.decimal 'points', default: '0.0'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'accomplishments_members', force: :cascade do |t|
    t.bigint 'accomplishment_id'
    t.bigint 'member_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'semester_id'
    t.index ['accomplishment_id'], name: 'index_accomplishments_members_on_accomplishment_id'
    t.index ['member_id'], name: 'index_accomplishments_members_on_member_id'
    t.index ['semester_id'], name: 'index_accomplishments_members_on_semester_id'
  end

  create_table 'events', force: :cascade do |t|
    t.text 'name'
    t.date 'date', null: false
    t.time 'time'
    t.decimal 'attendance_points', default: '0.0'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'event_type'
  end

  create_table 'events_members', id: false, force: :cascade do |t|
    t.bigint 'member_id'
    t.bigint 'event_id'
    t.index ['event_id'], name: 'index_events_members_on_event_id'
    t.index ['member_id'], name: 'index_events_members_on_member_id'
  end

  create_table 'manual_points', force: :cascade do |t|
    t.decimal 'points', default: '0.0'
    t.text 'reason_message'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'member_id'
    t.integer 'reason'
    t.index ['member_id'], name: 'index_manual_points_on_member_id'
  end

  create_table 'members', force: :cascade do |t|
    t.text 'name'
    t.text 'email', null: false
    t.integer 'class_year'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'role'
    t.index ['email'], name: 'index_members_on_email', unique: true
  end

  create_table 'semesters', force: :cascade do |t|
    t.text 'name'
    t.daterange 'dates', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'sessions', force: :cascade do |t|
    t.string 'session_id', null: false
    t.text 'data'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['session_id'], name: 'index_sessions_on_session_id', unique: true
    t.index ['updated_at'], name: 'index_sessions_on_updated_at'
  end

  add_foreign_key 'accomplishments_members', 'accomplishments'
  add_foreign_key 'accomplishments_members', 'members'
  add_foreign_key 'accomplishments_members', 'semesters'
  add_foreign_key 'events_members', 'events'
  add_foreign_key 'events_members', 'members'
  add_foreign_key 'manual_points', 'members'
end
