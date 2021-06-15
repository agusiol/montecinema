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

ActiveRecord::Schema.define(version: 20_210_614_112_829) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'cinema_halls', force: :cascade do |t|
    t.string 'name'
    t.integer 'capacity'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.text 'seats', default: [], array: true
  end

  create_table 'clients', force: :cascade do |t|
    t.string 'email'
    t.string 'name'
    t.integer 'age'
    t.boolean 'real_user'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'clients_promotion', force: :cascade do |t|
    t.bigint 'client_id'
    t.bigint 'promotion_id'
    t.datetime 'expiry_date'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['client_id'], name: 'index_clients_promotion_on_client_id'
    t.index ['promotion_id'], name: 'index_clients_promotion_on_promotion_id'
  end

  create_table 'jwt_denylist', force: :cascade do |t|
    t.string 'jti', null: false
    t.datetime 'exp', null: false
    t.index ['jti'], name: 'index_jwt_denylist_on_jti'
  end

  create_table 'movies', force: :cascade do |t|
    t.string 'title'
    t.string 'genre'
    t.integer 'age_allowed'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'duration'
  end

  create_table 'promotions', force: :cascade do |t|
    t.text 'description'
    t.string 'code'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'reservations', force: :cascade do |t|
    t.string 'status'
    t.bigint 'screening_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'ticket_desk_id'
    t.bigint 'client_id'
    t.index ['client_id'], name: 'index_reservations_on_client_id'
    t.index ['screening_id'], name: 'index_reservations_on_screening_id'
    t.index ['ticket_desk_id'], name: 'index_reservations_on_ticket_desk_id'
  end

  create_table 'screenings', force: :cascade do |t|
    t.datetime 'date'
    t.bigint 'cinema_hall_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'movie_id'
    t.index ['cinema_hall_id'], name: 'index_screenings_on_cinema_hall_id'
    t.index ['movie_id'], name: 'index_screenings_on_movie_id'
  end

  create_table 'ticket_desks', force: :cascade do |t|
    t.string 'category'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'tickets', force: :cascade do |t|
    t.string 'seat'
    t.string 'ticket_type'
    t.float 'price'
    t.bigint 'reservation_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['reservation_id'], name: 'index_tickets_on_reservation_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'reservations', 'clients'
  add_foreign_key 'reservations', 'screenings'
  add_foreign_key 'reservations', 'ticket_desks'
  add_foreign_key 'screenings', 'cinema_halls'
  add_foreign_key 'screenings', 'movies'
  add_foreign_key 'tickets', 'reservations'
end
