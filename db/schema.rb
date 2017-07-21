# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170720153544) do

  create_table "forecasts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "zip_code"
    t.string "conditions_main"
    t.string "conditions_desc"
    t.string "longitude"
    t.string "latitude"
    t.string "city_name"
    t.string "country"
    t.string "pressure"
    t.string "temp_k"
    t.string "wind_direction"
    t.string "wind_speed"
    t.string "humidity"
    t.string "timestamp"
  end

end