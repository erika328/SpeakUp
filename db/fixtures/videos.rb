videos = [
  { video_id: 'p2oIXSgqUjk', title: "Harry and the Snake | Harry Potter and the Philosopher's Stone", difficulty: 'Beginner', transcript_path: 'public/transcripts/harry_and_the_snake.txt' },
  { video_id: 'fBziSx7RtqY', title: "Ron receives a Howler | Harry Potter and the Chamber of Secrets", difficulty: 'Beginner', transcript_path: 'public/transcripts/ron_receives_a_howler.txt' },
  { video_id: 'x8kshJO2PG0', title: "Draco Malfoy Introduces Himself To Harry | Harry Potter and the Philosopher's Stone", difficulty: 'Beginner', transcript_path: 'public/transcripts/Malfoy_Introduces_Himself.txt' },
  { video_id: '71xBu_VHTfY', title: "Meet Buckbeak | Harry Potter and the Prisoner of the Azkaban", difficulty: 'Beginner', transcript_path: 'public/transcripts/Meet_Buckbeak.txt' },
  { video_id: 'Xn1adsMTIVU', title: "ENGLISH SPEECH | ZENDAYA: We're the Future", difficulty: 'Advanced', transcript_path: 'public/transcripts/zendaya_speech.txt' },
  { video_id: 'iRr9v_shgbY', title: "Emma Watson's Speech on Gender Equality | ENGLISH SPEECH", difficulty: 'Intermediate', transcript_path: 'public/transcripts/emma_watson_speech.txt' },
  { video_id: 'VnSMIgsPj5M', title: "Benedict Cumberbatch reads Sol LeWitt's letter to Eva Hesse", difficulty: 'Advanced', transcript_path: 'public/transcripts/benedict_cumberbatch_speech.txt' },
  { video_id: 'SX9mF288Tb8', title: "Tom Holland: The Puppy Interview", difficulty: 'Advanced', transcript_path: 'public/transcripts/tom_holland_interview.txt' },
  { video_id: 'k19WhcFH7WU', title: "Benedict Cumberbatch Plays With Puppies While Answering Fan Questions", difficulty: 'Advanced', transcript_path: 'public/transcripts/benedict_cumberbatch_plays_with_puppies.txt' },
  { video_id: 'nyhRNwTfydU', title: "Oprah Winfrey Motivation Speech", difficulty: 'Intermediate', transcript_path: 'public/transcripts/oprah_winfrey_speech.txt' },
  { video_id: 'HisYsqqszq0', title: "The Pencil's Tale - a story that everyone should hear", difficulty: 'Intermediate', transcript_path: 'public/transcripts/the_pencils_tale.txt' },
  { video_id: 'sWdTsesGvfU', title: "Learn to say NO and set boundaries for yourself | Oprah Winfrey", difficulty: 'Intermediate', transcript_path: 'public/transcripts/learn_to_say_no.txt' },
  { video_id: 'GvwDEcEwvEk', title: "Oprah Winfrey Motivational Speech", difficulty: 'Intermediate', transcript_path: 'public/transcripts/oprah_winfrey_motivational_speech.txt' },
  { video_id: 'GoNQmdjAV9k', title: "Happy Christmas, Harry and Ron | Harry Potter and the Philosopher's Stone", difficulty: 'Beginner', transcript_path: 'public/transcripts/happy_christmas_harry_and_ron.txt' },
  { video_id: '3NlGc3RHCS0', title: "My Daily Routine/ My day (Timetable)", difficulty: 'Beginner', transcript_path: 'public/transcripts/my_daily_routine.txt' },
  { video_id: 'aYRnM4nyuKs', title: "Inside Out 2 | Team", difficulty: 'Beginner', transcript_path: 'public/transcripts/inside_out_2.txt' },

  # 他にも追加していく
]

videos.each do |video|
  video_record = Video.seed(:video_id) do |s|
    s.video_id = video[:video_id]
    s.title = video[:title]
    s.difficulty = video[:difficulty]
  end.first

  transcript_content = File.read(Rails.root.join(video[:transcript_path]))
  Transcript.seed(:content) do |s|
    s.content = transcript_content
    s.video_id = video_record.id
  end
end