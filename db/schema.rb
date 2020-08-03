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

ActiveRecord::Schema.define(version: 2020_07_31_190113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "author_id"
    t.integer "post_id"
    t.integer "parent_comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "votable_type"
    t.bigint "votable_id"
    t.integer "karma", default: 0
    t.float "hotness"
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["votable_type", "votable_id"], name: "index_comments_on_votable_type_and_votable_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.string "url"
    t.text "content", null: false
    t.integer "author_id", null: false
    t.integer "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "votable_type"
    t.bigint "votable_id"
    t.integer "karma", default: 0
    t.string "slug"
    t.float "hotness"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
    t.index ["votable_type", "votable_id"], name: "index_posts_on_votable_type_and_votable_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "topic_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.integer "moderator_id", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_topics_on_slug", unique: true
    t.index ["title"], name: "index_topics_on_title", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "session_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "comment_karma", default: 0
    t.integer "post_karma", default: 0
    t.string "slug"
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer "value"
    t.integer "user_id"
    t.string "votable_type"
    t.integer "votable_id"
    t.index ["votable_id"], name: "index_votes_on_votable_id"
    t.index ["votable_type"], name: "index_votes_on_votable_type"
  end

end
