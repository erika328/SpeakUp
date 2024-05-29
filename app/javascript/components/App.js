import React, { useState, useEffect } from 'react'; 
import { ResultReason } from 'microsoft-cognitiveservices-speech-sdk'; 
import ShareButton from './ShareButton';

const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
const speechsdk = require('microsoft-cognitiveservices-speech-sdk');

export default function App() { 
  const [recognizedText, setRecognizedText] = useState('')
  const [displayAverageScore, setDisplayAverageScore] = useState('');
  const [displayAccuracyScore, setDisplayAccuracyScore] = useState('');
  const [displayPronunciationScore, setDisplayPronunciationScore] = useState('');
  const [displayFluencyScore, setDisplayFluencyScore] = useState('');
  const [displayCompletenessScore, setDisplayCompletenessScore] = useState('');

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

    recognizer.recognizeOnceAsync(result => {
      setIsLoading(false);
        if (result.reason === ResultReason.RecognizedSpeech) {
            // 発音評価の結果を取得
            const pronunciationResult = speechsdk.PronunciationAssessmentResult.fromResult(result);
            const accuracyScore = pronunciationResult.accuracyScore;
            const pronunciationScore = pronunciationResult.pronunciationScore;
            const fluencyScore = pronunciationResult.fluencyScore;
            const completenessScore = pronunciationResult.completenessScore;
            const averageScore = (accuracyScore + pronunciationScore + fluencyScore + completenessScore) / 4;

            saveScoreToDatabase(accuracyScore, pronunciationScore, fluencyScore, completenessScore, referenceTextId);
            setRecognizedText(`RECOGNIZED(認識した言葉): \n ${result.text}`);
            setDisplayAverageScore(`Average Score(平均): ${averageScore}%`);
            setDisplayAccuracyScore(`Accuracy Score(精度): ${accuracyScore}%`);
            setDisplayFluencyScore(`Fluency Score(流暢性): ${fluencyScore}%`);
            setDisplayCompletenessScore(`Completeness Score(完全性): ${completenessScore}%`)
            setDisplayPronunciationScore(`Pronunciation Score(発音): ${pronunciationScore}%`)
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
          <p>No texts available for the selected difficulty.</p>
        </div>
      );
    }

    function speakText(text) {
      const utterance = new SpeechSynthesisUtterance(text);
      utterance.lang = 'en-UK';
      speechSynthesis.speak(utterance);
  }

    function handleSpeakEnglishClick() {
      const englishText = referenceTextContent;
      speakText(englishText);
  }


return (
      <div className='p-5 md:bg-base-200 border-grey-200 md:min-h-96 md:border-2 md:w-auto md:rounded-2xl md:m-5 min-[320px]:border-t-2'>
        {/* <select onChange={(event) => setDifficulty(event.target.value)} value={difficulty}>
          <option value="Normal">Normal</option>
          <option value="Hard">Hard</option>
        </select> */}
        <label className="swap swap-flip text-xl">
          <input type="checkbox" onChange={(event) => setDifficulty(event.target.checked ? "Hard" : "Normal")} checked={difficulty === "Hard"} hidden />
          <div className="swap-on bg-[#001858] text-white rounded-3xl p-2 font-semibold"> Hard😈 </div>
          <div className="swap-off border-2 border-[#172c66] bg-white rounded-3xl p-2 font-semibold text-[#172c66]">Normal😇</div>
        </label>

          <div className='mt-5 space-y-3 text-[#172c66]'>
            <h3 className='font-semibold text-xl mb-2'>
            {referenceTextContent}</h3>
            <p className='text-sm'>「{referenceTextJapanese}」</p>
            <div className='my-2'>
              <i className="fa-solid fa-volume-high fa-xl" onClick={handleSpeakEnglishClick}></i>
            </div>
          </div>
          <div className="my-3 text-[#172c66]">
              <p>{recognizedText}</p><br/>
              <p>{displayAverageScore}</p>
              <p>{displayAccuracyScore}</p>
              <p>{displayFluencyScore}</p>
              <p>{displayPronunciationScore}</p>
              <p>{displayCompletenessScore}</p>
          </div>
          <div className='mt-10 flex justify-center'>
            {isLoading ? (
              <span className="loading loading-dots loading-lg text-[#5bcccc]"></span>
            ) : (
            <div className='bg-[#5bcccc] w-14 h-14 flex items-center justify-center rounded-full text-[#fffffe]' onClick={() => sttFromMic()}>
              <i className="fa-solid fa-microphone fa-2xl"></i>
            </div>
            )}
          </div>
          <div className='flex justify-center'>
            {displayAccuracyScore ? <ShareButton score={displayAverageScore} /> : null}
          </div>
      </div>
);

}
