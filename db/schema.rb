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

ActiveRecord::Schema.define(:version => 20130207054756) do

  create_table "prompt_categories", :force => true do |t|
    t.string   "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "prompt_items", :force => true do |t|
    t.string   "text"
    t.string   "hashtag"
    t.integer  "prompt_category_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "prompt_items", ["prompt_category_id"], :name => "index_prompt_items_on_prompt_category_id"

  create_table "prompts", :force => true do |t|
    t.integer  "prompt_category_id"
    t.integer  "prompt_item_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "hashtag"
  end

  add_index "prompts", ["prompt_category_id"], :name => "index_tweets_on_prompt_category_id"
  add_index "prompts", ["prompt_item_id"], :name => "index_tweets_on_prompt_item_id"

  create_table "tweets", :force => true do |t|
    t.integer  "tweet_id",      :limit => 8
    t.string   "text"
    t.string   "user_name"
    t.integer  "user_id",       :limit => 8
    t.integer  "retweet_count"
    t.string   "vine_url"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "hashtag_used"
    t.integer  "winner_of"
  end

end
