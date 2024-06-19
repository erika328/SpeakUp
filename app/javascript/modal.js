let wordId; // グローバルスコープでwordIdを定義

function showWordModal(element) {
  const wordId = element.getAttribute('data-word-id');
  const wordEnglish = element.getAttribute('data-word-english');
  const wordJapanese = element.getAttribute('data-word-japanese');
  const wordExample = element.getAttribute('data-word-example');
  const wordPartOfSpeech = element.getAttribute('data-word-part-of-speech');

  // Example sentenceがあるかどうかチェック
  let exampleSection = wordExample ? `
  <div>
    <label for="example_${wordId}" class="px-1">Example Sentence</label>
    <p id="example_${wordId}" class="font-semibold text-base block w-full px-5 py-3 border border-transparent rounded-lg bg-gray-50">${wordExample}</p>
  </div>
  ` : '';

  // モーダルの内容を更新する
  const modalBox = document.querySelector(`#my_modal_${wordId} .modal-box`);
  modalBox.innerHTML = `
    <div class="font-bold text-lg text-center text-[#172c66]">
      <div>
        <label for="english_word_${wordId}" class="px-1">English</label>
        <i class="hover:cursor-pointer fa-solid fa-volume-high fa-lg" id="speak_english_${wordId}"></i>
        <p id="english_word_${wordId}" class="font-semibold text-base block w-full px-5 py-3 border border-transparent rounded-lg bg-gray-50">${wordEnglish}</p>
      </div>
      <div>
        <label for="meaning_${wordId}" class="px-1" >Meaning</label>
        <p id="meaning_${wordId}", class="font-semibold text-base block w-full px-5 py-3  border border-transparent rounded-lg bg-gray-50">${wordJapanese}</p>
      </div>
      <div>
        <label for="part_of_speech_${wordId}" class="px-1" >Part Of Speech</label>
        <p id="part_of_speech_${wordId}", class="font-semibold text-base block w-full px-5 py-3  border border-transparent rounded-lg bg-gray-50">${wordPartOfSpeech}</p>
      </div>
      ${exampleSection}
    </div>
    <div class="fixed bottom-5 right-5 text-[#172c66]">
        <a href="/words/${wordId}/edit">
          <i class="fa-solid fa-pencil fa-xl"></i>
        </a>
    </div>
  `;

  // 読み上げボタンにイベントリスナーを追加
  const speakButton = document.getElementById(`speak_english_${wordId}`);
  speakButton.addEventListener('click', function() {
    speakText(wordEnglish);
  });

  // モーダルを表示する
  const modal = document.getElementById(`my_modal_${wordId}`);
  modal.showModal();
}

// テキストを読み上げる関数
function speakText(text) {
  const utterance = new SpeechSynthesisUtterance(text);
  utterance.lang = 'en-GB';
  speechSynthesis.speak(utterance);
}

document.addEventListener('DOMContentLoaded', setup);
document.addEventListener('turbo:load', setup);

function setup() {
  const cards = document.querySelectorAll('.card-modal');
  cards.forEach(function(card) {
    card.addEventListener('click', function() {
      showWordModal(this);
    });
  });
}

document.addEventListener("turbo:submit-end", function(event) {
  const modal = document.getElementById(`my_modal_${wordId}`);
  if (modal && event.detail.success) {
    modal.close(); // モーダルを閉じる
  }
});
