
import React, { useState } from 'react'; 

import { ResultReason } from 'microsoft-cognitiveservices-speech-sdk'; 


const speechsdk = require('microsoft-cognitiveservices-speech-sdk');

export default function App() { 
  const [displayText, setDisplayText] = useState('INITIALIZED: ready to test speech...');
  const referenceTexts = gon.reference_text.map(text => text.english);
  const [selectedTextIndex, setSelectedTextIndex] = useState(Math.floor(Math.random() * referenceTexts.length));

  const referenceText = referenceTexts[selectedTextIndex];

async function sttFromMic() {
  const SPEECH_Key = gon.speech_api_key;
  const SPEECH_Region = gon.speech_region;
  const speechConfig = speechsdk.SpeechConfig.fromSubscription(SPEECH_Key, SPEECH_Region);
  speechConfig.speechRecognitionLanguage = 'en-US';
  
  const audioConfig = speechsdk.AudioConfig.fromDefaultMicrophoneInput();
  const recognizer = new speechsdk.SpeechRecognizer(speechConfig, audioConfig);

  // const referenceText = "Hello there, how are you doing? It's been a while since we talked to each other! Everything is alright, I hope?"; // 評価する参照テキスト
  const pronunciationAssessmentConfig = new speechsdk.PronunciationAssessmentConfig(
      referenceText,
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

          setDisplayText(`RECOGNIZED: Text=${result.text}\nAccuracy Score: ${accuracyScore}, Pronunciation Score: ${pronunciationScore}
          , Fluency Score: ${fluencyScore}, Completeness Score: ${completenessScore}`);
      } else {
          setDisplayText('ERROR: Speech was cancelled or could not be recognized. Ensure your microphone is working properly.');
      }
  });
}

return (
  <div className="app-container">
      <h1 className="display-4 mb-3">Speech sample app</h1>

      <div className="row main-container">
          <div className="col-6">
              <div className="fas fa-microphone fa-lg mr-2" onClick={() => sttFromMic()}>Convert speech to text from your mic.</div>
          </div>
          <div className="col-6 rounded">
              <code>{displayText}</code>
          </div>
          <div>
          <p><strong>English:</strong> {referenceTexts[selectedTextIndex]}</p>
            <p><strong>Japanese:</strong> {gon.reference_text[selectedTextIndex].japanese}</p>
          </div>
      </div>
  </div>
);
}
