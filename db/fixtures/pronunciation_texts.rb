sentences = [
  { english_text: "Hello there, how are you doing?", japanese_text: "こんにちは、調子はどう？", difficulty: "Normal" },
  { english_text: "It's been a while since we talked to each other!", japanese_text: "久しぶりに話したね！", difficulty: "Normal" },
  { english_text: "Is everything alright?", japanese_text: "全部順調？", difficulty: "Normal" },
  { english_text: "Could I have a cup of coffee please?", japanese_text: "コーヒーを一杯いただけますか？", difficulty: "Normal" },
  { english_text: "Would you mind if I sit here?", japanese_text: "ここに座ってもいいですか？", difficulty: "Normal" },
  { english_text: "May I ask you a question? Where is the bathroom?", japanese_text: "質問してもいいですか？トイレはどこでしょうか。", difficulty: "Normal" },
  { english_text: "Oh, sorry I didn't notice that you were there!", japanese_text: "あぁ、ごめんね。そこにあなたがいるって知らなかった！", difficulty: "Normal" },
  { english_text: "The only person you are destined to become is the person you decide to be.", japanese_text: "あなたがこれからどんな人間になるかは、あなた自身が決めること。", difficulty: "Normal" },
  { english_text: "What do you usually do every day?", japanese_text: "毎日何をして過ごしていますか？", difficulty: "Normal" },
  { english_text: "What are you doing tomorrow?", japanese_text: "明日は何をしていますか？", difficulty: "Normal" },
  { english_text: "I usually watch a movie on my days off.", japanese_text: "休みの日は映画をみて過ごします。", difficulty: "Normal" },
  { english_text: "Would you mind giving me a hand?", japanese_text: "手伝っていただけませんか？", difficulty: "Normal" },
  { english_text: "Would it be possible to meet you again?", japanese_text: "もう一度お会いすることはできますか？", difficulty: "Normal" },
  { english_text: "May I ask you to take a picture for us?", japanese_text: "わたしたちの写真を取っていただけますか？", difficulty: "Normal" },
  { english_text: "Could you please talk a bit slower?", japanese_text: "もう少しゆっくり話していただけますか？", difficulty: "Normal" },

  { english_text: "Peter Piper picked a peck of pickled peppers.
                  A peck of pickled peppers Peter Piper picked.
                  If Peter Piper picked a peck of pickled peppers,
                  Where’s the peck of pickled peppers Peter Piper picked?",
  japanese_text: "ピーター・パイパーはたくさんの唐辛子の酢漬けを拾った。
                  ピーター・パイパーが拾ったたくさんの唐辛子の酢漬け。
                  もしピーター・パイパーがたくさんの唐辛子の酢漬けを拾ったら、
                  ピーター・パイパーが拾ったたくさんの唐辛子の酢漬けはどこにある？", difficulty: "Hard" },
  { english_text: "A big black bug bit a big black bear, but the big black bear bit the big black bug back.",
  japanese_text: "大きな黒い虫が大きい黒い熊を噛んだ。でもその大きな黒い熊はその大きな黒い虫を噛み返した。", difficulty: "Hard" },
  { english_text: "Betty bought some butter but the butter Betty bought was bitter. So Betty bought some better butter, and the better butter Betty bought was better than the bitter butter Betty bought before.",
  japanese_text: "ベティーはバターを買った。でもベティーが買ったバターは苦かった。だからベティーはより良いバターを買った。ベティーが買ったバターは、前に買ったバターよりも良かった。", difficulty: "Hard" },
  { english_text: "She sells seashells on the seashore. The shells she sells are seashells, I’m sure. So if she sells seashells on the seashore, then I’m sure she sells seashore shells.",
  japanese_text: "彼女は海岸で貝殻を売っている。彼女が売っている殻は貝殻で間違いない。だから、もし彼女が海岸で貝殻を売っているなら、彼女は間違いなく海岸の殻を売っているよ。", difficulty: "Hard" },
  { english_text: "Red lorry, yellow lorry, red lorry, yellow lorry.",
  japanese_text: "赤いトラック、黄色いトラック、赤いトラック、黄色いトラック。", difficulty: "Hard" },
  { english_text: "Black bug bleeds black blood, what color blood does a blue bug bleed?",
  japanese_text: "黒い虫は黒い血を流す。青い虫はどんな色の血を流すだろうか？", difficulty: "Hard" },
  { english_text: "Susie works in a shoeshine shop. Where she shines she sits, and where she sits she shines.",
  japanese_text: "スージーは靴磨き店で働いています。彼女が磨くところに彼女は座り、そして彼女が座るところで彼女は磨きます。", difficulty: "Hard" },
  { english_text: "How can a clam cram in a clean cream can?",
  japanese_text: "きれいなクリーム缶の中になんで大量の貝が入っているの？", difficulty: "Hard" },
  { english_text: "I thought I thought of thinking of thanking you.",
  japanese_text: "あなたに感謝することを考えてたことを考えていたことを考えていた。", difficulty: "Hard" },
  { english_text: "Four furious friends fought for the phone.",
  japanese_text: "激怒した4人の友人が電話を奪い合った。", difficulty: "Hard" },
  { english_text: "Of all the vids I’ve ever viewed, I’ve never viewed a vid as valued as Alex’s engVid vid.",
  japanese_text: "私が今まで見た全てのビデオの中で、アレックスの “engVid” のビデオより価値があるビデオは見たことがない。", difficulty: "Hard" },
  { english_text: "How much wood would a woodchuck chuck if a woodchuck could chuck wood?",
  japanese_text: "ウッドチャックが木を放り投げることができるのなら、どれくらいの量の木を放り投げるだろうか？", difficulty: "Hard" },
  { english_text: "You know New York, you need New York, you know you need unique New York.",
  japanese_text: "あなたはニューヨークを知っている。あなたはニューヨークが必要だ。あなたは独特なニューヨークをあなたが必要なことを知っている。", difficulty: "Hard" },
  { english_text: "Lesser leather never weathered wetter weather better.",
  japanese_text: "良くない革は決して湿った天気に耐えられない。", difficulty: "Hard" },
  { english_text: "Near an ear, a nearer ear, a nearly eerie ear.",
  japanese_text: "耳の近く、より近い耳、ほぼ不気味な耳。", difficulty: "Hard" },
  
]

sentences.each do |sentence|
  PronunciationText.find_or_create_by(
    english_text: sentence[:english_text],
    japanese_text: sentence[:japanese_text],
    difficulty: sentence[:difficulty]
  )
end