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

ActiveRecord::Schema[7.1].define(version: 2024_06_29_081625) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "video_id"], name: "index_likes_on_user_id_and_video_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
    t.index ["video_id"], name: "index_likes_on_video_id"
  end

  create_table "pronunciation_scores", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pronunciation_text_id", null: false
    t.decimal "accuracy_score", precision: 5, scale: 2, null: false
    t.decimal "pronunciation_score", precision: 5, scale: 2, null: false
    t.decimal "fluency_score", precision: 5, scale: 2, null: false
    t.decimal "completeness_score", precision: 5, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pronunciation_text_id"], name: "index_pronunciation_scores_on_pronunciation_text_id"
    t.index ["user_id"], name: "index_pronunciation_scores_on_user_id"
  end

  create_table "pronunciation_texts", force: :cascade do |t|
    t.text "english_text", null: false
    t.text "japanese_text", null: false
    t.string "difficulty", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["difficulty"], name: "index_pronunciation_texts_on_difficulty"
  end

  create_table "transcript_words", force: :cascade do |t|
    t.bigint "transcript_id", null: false
    t.bigint "word_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transcript_id", "word_id"], name: "index_transcript_words_on_transcript_id_and_word_id", unique: true
    t.index ["transcript_id"], name: "index_transcript_words_on_transcript_id"
    t.index ["word_id"], name: "index_transcript_words_on_word_id"
  end

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
    t.string "provider"
    t.string "uid"
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
    t.string "meaning", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "review_status", default: "hard"
    t.date "next_review_date"
    t.string "example"
    t.string "part_of_speech"
    t.index ["user_id", "english_word", "part_of_speech"], name: "index_words_on_user_id_and_english_word_and_part_of_speech", unique: true
    t.index ["user_id"], name: "index_words_on_user_id"
  end

  add_foreign_key "likes", "users"
  add_foreign_key "likes", "videos"
  add_foreign_key "pronunciation_scores", "pronunciation_texts"
  add_foreign_key "pronunciation_scores", "users"
  add_foreign_key "transcript_words", "transcripts"
  add_foreign_key "transcript_words", "words"
  add_foreign_key "transcripts", "videos"
  add_foreign_key "words", "users"
end
