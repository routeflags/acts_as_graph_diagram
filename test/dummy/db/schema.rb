# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_220_617_084_205) do
  create_table 'edges', force: :cascade do |t|
    t.string 'comment', default: ''
    t.integer 'figure', default: 0
    t.integer 'lower_figure', default: 0
    t.integer 'higher_figure', default: 0
    t.boolean 'directed', default: true
    t.string 'destination_type'
    t.integer 'destination_id'
    t.string 'departure_type'
    t.integer 'departure_id'
    t.datetime 'created_at', precision: nil
    t.datetime 'updated_at', precision: nil
    t.index %w[departure_id departure_type], name: 'fk_edges_departure'
    t.index %w[destination_id destination_type], name: 'fk_edges_destination'
  end

  create_table 'gods', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
