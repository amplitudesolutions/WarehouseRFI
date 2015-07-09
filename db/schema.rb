# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150709061459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "materials", force: :cascade do |t|
    t.string   "uan"
    t.string   "material_account"
    t.string   "isometric_number"
    t.string   "row_number"
    t.string   "construction_unit"
    t.string   "process_unit"
    t.string   "corrosion_system"
    t.string   "date_of_material_transfer"
    t.string   "revision_material_transfer"
    t.string   "status_of_material"
    t.string   "nominal_bore"
    t.string   "fluid_code"
    t.string   "piping_class_of_line"
    t.string   "insulation_type"
    t.string   "insulation_thickness"
    t.string   "prefabrication_code"
    t.string   "subsystem"
    t.string   "material_package"
    t.string   "procurement_selection"
    t.string   "spool"
    t.string   "component_number"
    t.string   "designation"
    t.string   "dn"
    t.string   "dimension_1"
    t.string   "dimension_2"
    t.string   "dimension_3"
    t.string   "dimension_4"
    t.string   "dn_2"
    t.string   "piping_class"
    t.string   "support_class"
    t.string   "store_code"
    t.string   "id_prefabrication"
    t.string   "quantity"
    t.string   "component_family"
    t.string   "weight"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "laying_type"
    t.string   "isomet_code"
  end

end
