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

ActiveRecord::Schema.define(version: 20151017162711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "finca_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fincas", force: :cascade do |t|
    t.string   "nombre_finca"
    t.string   "localizacion"
    t.string   "clima"
    t.integer  "capacidad"
    t.string   "informacion"
    t.float    "lat"
    t.float    "lon"
    t.integer  "precio"
    t.integer  "idowner"
    t.string   "owner"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer  "finca_id"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leasings", force: :cascade do |t|
    t.integer  "finca_id"
    t.string   "datetime"
    t.string   "estado"
    t.integer  "user_id"
    t.boolean  "calificacion"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "ownerships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "finca_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "finca_id"
    t.integer  "votos1"
    t.integer  "votos2"
    t.integer  "votos3"
    t.integer  "votos4"
    t.integer  "votos5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "finca_id"
    t.string   "nombre"
    t.integer  "cedula"
    t.string   "email"
    t.integer  "telefono",   limit: 8
    t.integer  "celular",    limit: 8
    t.string   "password"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.text     "username"
    t.text     "apellidos"
  end

end
