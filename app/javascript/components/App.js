import React, { useState, useEffect } from 'react'; 
import { ResultReason } from 'microsoft-cognitiveservices-speech-sdk'; 

const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
const speechsdk = require('microsoft-cognitiveservices-speech-sdk');

export default function App() { 
  const [displayText, setDisplayText] = useState('Ready to test speech...');
  const [isLoading, setIsLoading] = useState(false);
  const [difficulty, setDifficulty] = useState('Normal');
  const [selectedTextIndex, setSelectedTextIndex] = useState(0);
  const [referenceTexts, setReferenceTexts] = useState(gon.reference_text);
  
   useEffect(() => {
    if (referenceTexts && referenceTexts.length > 0) {
      const num = difficulty === 'Normal' ? gon.reference_text.length : gon.reference_text_hard.length;
      setSelectedTextIndex(Math.floor(Math.random() * num));
      setReferenceTexts(difficulty === 'Normal' ? gon.reference_text : gon.reference_text_hard);
    }
  }, [difficulty]);

  const referenceText = referenceTexts[selectedTextIndex == 0 ? 0  : selectedTextIndex-1];
  const referenceTextId = referenceText.id;
  const referenceTextContent = referenceText.english;
  const referenceTextJapanese = referenceText.japanese;

  async function sttFromMic() {
    setIsLoading(true);
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

    setDisplayText('Speak into your microphone...');

    recognizer.recognizeOnceAsync(result => {
      setIsLoading(false);
        if (result.reason === ResultReason.RecognizedSpeech) {
            // 発音評価の結果を取得
            const pronunciationResult = speechsdk.PronunciationAssessmentResult.fromResult(result);
            const accuracyScore = pronunciationResult.accuracyScore;
            const pronunciationScore = pronunciationResult.pronunciationScore;
            const fluencyScore = pronunciationResult.fluencyScore;
            const completenessScore = pronunciationResult.completenessScore;

            saveScoreToDatabase(accuracyScore, pronunciationScore, fluencyScore, completenessScore, referenceTextId);
            setDisplayText(`RECOGNIZED(認識した言葉): Text=${result.text}\nAccuracy Score: ${accuracyScore}, Pronunciation Score: ${pronunciationScore}
            , Fluency Score: ${fluencyScore}, Completeness Score: ${completenessScore}`);
        } else {
            setDisplayText('ERROR: Speech was cancelled or could not be recognized. Ensure your microphone is working properly.');
        }
    });
  }

const pronunciationScoresPath = document.getElementById('pronunciation-scores-path').dataset.path;

  async function saveScoreToDatabase(accuracyScore, pronunciationScore, fluencyScore, completenessScore, referenceTextId)  {
    try {
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
    }
  }

    // referenceTextsが空またはundefinedでないかチェック
    if (!referenceTexts || referenceTexts.length === 0) {
      return (
        <div>
          <select onChange={(event) => setDifficulty(event.target.value)} value={difficulty}>
            <option value="Normal">Normal</option>
            <option value="Hard">Hard</option>
          </select>
          <p>No texts available for the selected difficulty.</p>
        </div>
      );
    }

return (
        <div className='p-5 border-grey-200 md:min-h-96 md:border-2 md:w-auto md:rounded-2xl md:m-5 min-[320px]:border-t-2'>
        <select onChange={(event) => setDifficulty(event.target.value)} value={difficulty}>
          <option value="Normal">Normal</option>
          <option value="Hard">Hard</option>
        </select>
          <div>
            <p><strong>English:</strong><br/> {referenceTextContent}</p>
            <p><strong>Japanese:</strong><br/> {referenceTextJapanese}</p>
          </div>
          <div className="">
            <div className='md:mt-60 min-[320px]:mt-28'>
            <div className="text-blue-600 mb-3">
                <code>{displayText}</code>
            </div>
              {isLoading ? (
                <span className="loading loading-dots loading-lg text-blue-600"></span>
              ) : (
              <div onClick={() => sttFromMic()}>
                <i className="fa-solid fa-microphone fa-2xl text-blue-600"></i>
              </div>
              )}
            </div>
          </div>
        </div>
);

}
