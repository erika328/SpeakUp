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

ActiveRecord::Schema[7.1].define(version: 2024_05_04_082932) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transcripts", force: :cascade do |t|
    t.text "content"
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "index_transcripts_on_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", null: false
    t.string "difficulty", null: false
    t.index ["difficulty"], name: "index_videos_on_difficulty"
    t.index ["video_id"], name: "index_videos_on_video_id", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "english_word", null: false
    t.string "japanese_meaning", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["english_word"], name: "index_words_on_english_word", unique: true
    t.index ["user_id"], name: "index_words_on_user_id"
  end

  add_foreign_key "transcripts", "videos"
  add_foreign_key "words", "users"
end
