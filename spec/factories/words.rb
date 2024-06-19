FactoryBot.define do
  factory :word do
    english_word { "test" }
    meaning { "a procedure intended to establish the quality, performance, or reliability of something" }
    part_of_speech { "noun (名詞)" }
    example { "This is a test sentence." }
  end
end