import React, { useState, useEffect } from 'react'; 
import { ResultReason } from 'microsoft-cognitiveservices-speech-sdk'; 
import ShareButton from './ShareButton';
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend } from 'chart.js';
import { Bar } from 'react-chartjs-2';
import ChartDataLabels from 'chartjs-plugin-datalabels';

ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend, ChartDataLabels);

const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
const speechsdk = require('microsoft-cognitiveservices-speech-sdk');

export default function App() { 
  const [recognizedText, setRecognizedText] = useState('')
  const [displayAverageScore, setDisplayAverageScore] = useState('');

  const [scores, setScores] = useState({
    averageScore: 0,
    accuracyScore: 0,
    pronunciationScore: 0,
    fluencyScore: 0,
    completenessScore: 0
  });

  const data = {
    labels: ['Average(平均)','Accuracy(精度)', 'Pronunciation(発音)', 'Fluency(流暢性)', 'Completeness(完全性)'],
    datasets: [{
        label: '',
        data: [
            scores.averageScore,
            scores.accuracyScore,
            scores.pronunciationScore,
            scores.fluencyScore,
            scores.completenessScore
        ],
        backgroundColor: [
          'rgba(75, 192, 192, 0.2)', // Average
          'rgba(54, 162, 235, 0.2)', // Accuracy
          'rgba(255, 206, 86, 0.2)', // Pronunciation
          'rgba(153, 102, 255, 0.2)', // Fluency
          'rgba(255, 99, 132, 0.2)'  // Completeness
      ],
      borderColor: [
          'rgba(75, 192, 192, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(153, 102, 255, 1)',
          'rgba(255, 99, 132, 1)'
      ],
        borderWidth: 1
    }]
  };
  
  const options = {
    indexAxis: 'y', // 横向きバーに設定
    aspectRatio: 2, // チャートのアスペクト比を調整
    scales: {
        x: {
            beginAtZero: true,
            max: 100
        }
    },
    plugins: {
      legend: {
          display: false // 凡例を非表示に設定
      },
      tooltip: {
          callbacks: {
              label: function(context) {
                  return context.raw.toFixed(1) + '%'; // ツールチップの値を小数点第一位まで表示
              }
          }
      },
      datalabels: {
        anchor: 'end',
        align: function(context) {
            var value = context.dataset.data[context.dataIndex];
            return value > 90 ? 'start' : 'end'; // スコアが高い場合はラベルを内側に表示
        },
        color: function(context) {
            var value = context.dataset.data[context.dataIndex];
            return value > 90 ? 'black' : 'black'; // ラベルの色を調整
        },
        formatter: function(value) {
            return value.toFixed(1) + '%'; // バー上のラベルを小数点第一位まで表示
        }
    }
  }
  };

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
            setScores({
              averageScore,
              accuracyScore,
              pronunciationScore,
              fluencyScore,
              completenessScore
            });
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
        const flashMessage = document.getElementById('flash-message');
        flashMessage.classList.remove('hidden');
        setTimeout(() => {
          flashMessage.classList.add('hidden');
        }, 6000); 
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
              <i className="fa-solid fa-volume-high fa-xl hover:cursor-pointer" onClick={handleSpeakEnglishClick}></i>
            </div>
          </div>
          <div className="mt-5 text-[#172c66]">
              <p>{recognizedText}</p><br/>
              {!isLoading && scores.averageScore !== 0 && (
                <Bar data={data} options={options} />
              )}
          </div>
          <div className='mt-10 flex justify-center'>
            {isLoading ? (
              <span className="loading loading-dots loading-lg text-[#5bcccc]"></span>
            ) : (
            <div className='bg-[#5bcccc] hover:cursor-pointer w-14 h-14 flex items-center justify-center rounded-full text-[#fffffe]' onClick={() => sttFromMic()}>
              <i className="fa-solid fa-microphone fa-2xl"></i>
            </div>
            )}
          </div>
          <div className='flex justify-center'>
            {recognizedText ? <ShareButton score={displayAverageScore} /> : null}
          </div>
      </div>
);

}
