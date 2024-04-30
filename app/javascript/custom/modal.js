

function showWordModal(element) {
  const wordId = element.getAttribute('data-word-id');
  const wordEnglish = element.getAttribute('data-word-english');
  const wordJapanese = element.getAttribute('data-word-japanese')

  // モーダルの内容を更新する
  const modalBox = document.querySelector('#my_modal_2 .modal-box');
  modalBox.innerHTML = `
    <div class="font-bold text-lg text-center">
      <div>
        <label for="english_word" class="px-1">English</label>
        <p id="english_word" class="block w-full px-5 py-3 border border-transparent rounded-lg bg-gray-50">${wordEnglish}</p>
      </div>
      <div>
        <label for="japanese_meaning" class="px-1" >Japanese</label>
        <p id="japanese_meaning", class="block w-full px-5 py-3  border border-transparent rounded-lg bg-gray-50">${wordJapanese}</p>
      </div>
    </div>
    <div class="fixed bottom-5 right-5">
        <a href="/words/${wordId}/edit">
          <i class="fa-solid fa-pencil fa-xl"></i>
        </a>
    </div>
  `;

  // モーダルを表示する
  const modal = document.getElementById('my_modal_2');
  modal.showModal();
}

document.addEventListener('DOMContentLoaded', setup);
document.addEventListener('turbo:load', setup);

function setup() {
  const cards = document.querySelectorAll('.card');
  cards.forEach(function(card) {
    card.addEventListener('click', function() {
      showWordModal(this);
    });
  });
}

document.addEventListener("turbo:submit-end", function(event) {
  const modal = document.getElementById('my_modal_2');
  if (modal && event.detail.success) {
    modal.close(); // モーダルを閉じる
  }
});

export { showWordModal };
