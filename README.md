# SpeakUp
## サービス概要
英語学習のためのアプリです。スピーキング力の向上に特化していて、シャドーイング、発音採点を通してスピーキング練習をしながら、単語、フレーズ登録機能によって新たな単語やフレーズを学ぶことができます。

## このサービスへの思い・作りたい理由
- スピーキング力向上へのハードルを下げたい
  一人での学習ではなかなかスピーキング力を向上することは難しいです。単語や文法など、教科書で勉強できることは沢山インプットしてきたけれど、話すとなると話せないという英語学習者を沢山みてきましたし、私自身もそうでした。一人でもアウトプットの練習ができるアプリを作りたいと思ったのがきっかけです。
- スピーキング力向上に効果的なシャドーイングができるアプリが少ないため
  動画の音声に合わせて同じスピードで同時に話す練習をすることをシャドーイングといいます。この学習方法はスピーキング力向上に効果的と言われていますが、まず動画のスクリプトを全てどこかに書き写してからしか学習が始められません。私自身、この書き写しが面倒で練習がなかなかできていないのでこの面倒なステップを取り除いて、すぐに練習できる環境を作りたいと思いました。
- 単純に英語が好き
  英語ができるようになって一番楽しい瞬間は、外国人とコミュニケーションが取れた時だと思います。話せるようになった楽しさをたくさんの英語学習者に味わってもらいたいです。
## ユーザー層について
- 英語のスピーキング力を向上させたいと思っている人
- 対人でのスピーキング練習は緊張するので一人で練習したいと思っている人
- ある程度のスピーキング力はあるが、会話のピッチや発音をネイティブにより近づけたいと思っている人

## サービスの利用イメージ
- シャドーイング練習
  あらかじめ用意された動画とスクリプトを使い、自分のやりたいようにシャドーイング練習をする。難易度別で分けられた動画一覧から選ぶことができる。
- 発音採点
  問題文をマイクに向かって読み、採点する。どの単語が発音できていなかったのかなどを知り分析できる。
- 単語、フレーズ保存
  シャドーイング、発音採点で学んだ単語やフレーズを都度マイページに保存しておき、後で振り返ることができる。

## ユーザーの獲得について
会員登録不要でシャドーイング、発音採点が体験できます。会員限定で視聴できる動画の種類を増やしたり、単語・英文保存機能を紹介し会員登録へ促す。

## サービスの差別化ポイント・推しポイント
英語学習系サービスは数多く存在しますが、シャドーイング学習が一つのサービスで完結しているものを見たことがないので、発音採点や単語・英文登録機能だけのものと差別化できると考えています。

## 機能候補
### MVPリリース
- 新規会員登録
- ログイン・ログアウト
- パスワードリセット
- 単語・英文登録
- シャドーイング動画・スクリプト
- 発音採点
- Xシェア

### 本リリース
- 単語翻訳
- 単語翻訳検索時のオートコンプリート
- 発音点数ランキング
- 保存した単語・英文の振り返り（暗記カードのように振り返りできる機能）

## 機能の実装方針予定
- 新規会員登録、ログイン・ログアウト、パスワードリセット
  Devise、Google認証
- シャドーイング動画
  Youtube IFrame Player API
- 発音採点
  Azure Cognitive Services Speech SDK

## 主な使用技術
### サーバーサイド
- Ruby3.2.2
- Rails7.0.8
### データベース
- postgres
### 描画関係
- HTML
- Tailwind CSS + Daisy UI
- JavaScript
- HotWire
### デプロイ
- Fly.io

## 画面遷移図
https://www.figma.com/file/EjuNvUqVm2o4K0gzmJQXDa/SpeakUp?type=design&node-id=0%3A1&mode=design&t=Xr7g2WWl6wiogAZH-1
