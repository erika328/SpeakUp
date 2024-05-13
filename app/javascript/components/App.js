
import React, { useState } from 'react'; 

import { ResultReason } from 'microsoft-cognitiveservices-speech-sdk'; 

const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
const speechsdk = require('microsoft-cognitiveservices-speech-sdk');

export default function App() { 
  const [displayText, setDisplayText] = useState('INITIALIZED: ready to test speech...');
  const referenceTexts = gon.reference_text.map(text => {
    return {
      id: text.id, // テキストのID
      text: text.english, // テキストの内容
      difficulty: text.difficulty
    };
  });

  const [selectedTextIndex, setSelectedTextIndex] = useState(Math.floor(Math.random() * referenceTexts.length));

  const referenceText = referenceTexts[selectedTextIndex];
  const referenceTextId = referenceText.id;
  const referenceTextContent = referenceText.text; 

  async function sttFromMic() {
    const SPEECH_Key = gon.speech_api_key;
    const SPEECH_Region = gon.speech_region;
    const speechConfig = speechsdk.SpeechConfig.fromSubscription(SPEECH_Key, SPEECH_Region);
    speechConfig.speechRecognitionLanguage = 'en-US';
    
    const audioConfig = speechsdk.AudioConfig.fromDefaultMicrophoneInput();
    const recognizer = new speechsdk.SpeechRecognizer(speechConfig, audioConfig);

    const pronunciationAssessmentConfig = new speechsdk.PronunciationAssessmentConfig(
        referenceTextContent,
        speechsdk.PronunciationAssessmentGradingSystem.HundredMark,
        speechsdk.PronunciationAssessmentGranularity.Phonetic,
        true
    );
    pronunciationAssessmentConfig.applyTo(recognizer);

    setDisplayText('speak into your microphone...');

    recognizer.recognizeOnceAsync(result => {
        if (result.reason === ResultReason.RecognizedSpeech) {
            // 発音評価の結果を取得
            const pronunciationResult = speechsdk.PronunciationAssessmentResult.fromResult(result);
            const accuracyScore = pronunciationResult.accuracyScore;
            const pronunciationScore = pronunciationResult.pronunciationScore;
            const fluencyScore = pronunciationResult.fluencyScore;
            const completenessScore = pronunciationResult.completenessScore;

            saveScoreToDatabase(accuracyScore, pronunciationScore, fluencyScore, completenessScore, referenceTextId);
            setDisplayText(`RECOGNIZED: Text=${result.text}\nAccuracy Score: ${accuracyScore}, Pronunciation Score: ${pronunciationScore}
            , Fluency Score: ${fluencyScore}, Completeness Score: ${completenessScore}`);
        } else {
            setDisplayText('ERROR: Speech was cancelled or could not be recognized. Ensure your microphone is working properly.');
        }
    });
  }

  // パスを取得する
const pronunciationScoresPath = document.getElementById('pronunciation-scores-path').dataset.path;

  async function saveScoreToDatabase(accuracyScore, pronunciationScore, fluencyScore, completenessScore, referenceTextId)  {
    try {
      // スコアのデータをサーバーに送信するためのリクエストを作成
      const response = await fetch(pronunciationScoresPath, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Turbo-Frame': 'target-frame', 
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({
          pronunciation_score: {
            accuracy_score: accuracyScore,
            pronunciation_score: pronunciationScore,
            fluency_score: fluencyScore,
            completeness_score: completenessScore,
            pronunciation_text_id: referenceTextId
          },
        }),
      });
  
      if (response.ok) {
        // データが正常に保存された場合の処理
        console.log('Score saved successfully');
        // フラッシュメッセージを表示するなどの処理を追加
    } else {
        throw new Error('Failed to save score');
    }
    } catch (error) {
        console.error('Error saving score:', error);
        // エラーが発生した場合の処理
        // 例えば、ユーザーにエラーが発生したことを通知するなど
    }
  }

return (
  <div className="app-container">
      <div className="row main-container">
          <div className="col-6">
              <div className="fas fa-microphone fa-lg mr-2" onClick={() => sttFromMic()}>Convert speech to text from your mic.</div>
          </div>
          <div className="col-6 rounded">
              <code>{displayText}</code>
          </div>
          <div>
          <p><strong>English:</strong> {referenceTexts[selectedTextIndex].text}</p>
            <p><strong>Japanese:</strong> {gon.reference_text[selectedTextIndex].japanese}</p>
          </div>
      </div>
  </div>
);

}
