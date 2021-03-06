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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130608232324) do

  create_table "keywords", :force => true do |t|
    t.string   "name"
    t.integer  "stream_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stocks", :force => true do |t|
    t.string   "name"
    t.string   "symbol"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "time_zone"
  end

  create_table "streams", :force => true do |t|
    t.string   "name"
    t.integer  "stock_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "consumer_key"
    t.string   "consumer_secret"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
  end

  create_table "tweets", :force => true do |t|
    t.datetime "date"
    t.integer  "stream_id"
    t.integer  "mood_positive"
    t.integer  "mood_negative"
    t.integer  "tweet_count"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
