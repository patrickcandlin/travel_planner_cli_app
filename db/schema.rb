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

ActiveRecord::Schema.define(version: 2019_06_19_204757) do

  create_table "countries", force: :cascade do |t|
    t.string "countryName"
    t.string "capital"
    t.string "currencyCode"
    t.string "countryCode"
    t.string "population"
  end

  create_table "travelers", force: :cascade do |t|
    t.string "userName"
  end

  create_table "trips", force: :cascade do |t|
    t.float "budget"
    t.text "tripNotes"
    t.integer "traveler_id"
    t.integer "country_id"
    t.index ["country_id"], name: "index_trips_on_country_id"
    t.index ["traveler_id"], name: "index_trips_on_traveler_id"
  end

end
