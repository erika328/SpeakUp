document.addEventListener('DOMContentLoaded', () => {
  const container = document.querySelector('.transcript');
  const translateButton = document.getElementById('translate-button');
  let selectionTimeout;

  const handleSelection = () => {
    clearTimeout(selectionTimeout);
    selectionTimeout = setTimeout(() => {
      const selectedText = window.getSelection().toString().trim();

      if (selectedText) {
        translateButton.classList.remove('hidden');

        translateButton.onclick = () => {
          if (selectedText.split(/\s+/).length > 1) {
            alert('Please select only one word.');
          } else {
            fetch(`/words/translate_text?text=${selectedText}`)
              .then(response => response.json())
              .then(data => {
                if (data.translated_text) {
                  openModalWithWord(selectedText, data.translated_text);
                } else {
                  alert('Translation failed: ' + data.error);
                }
              });
          }
        };
      } else {
        translateButton.classList.add('hidden');
      }
    }, 500); // 500msの遅延を設定して、ドラッグが完了するのを待つ
  };

  const handleMouseUp = () => {
    const selectedText = window.getSelection().toString().trim();

    if (!selectedText) {
      translateButton.classList.add('hidden');
    }
  };

  container.addEventListener('mouseup', handleSelection);
  container.addEventListener('touchend', handleSelection);
  document.addEventListener('click', handleMouseUp);

  function openModalWithWord(word, meaning) {
    const englishWordInput = document.querySelector('input[id="english_word"]');
    const meaningInput = document.querySelector('textarea[id="meaning"]');

    if (englishWordInput && meaningInput) {
      englishWordInput.value = word;
      meaningInput.value = meaning;
      document.getElementById('my_modal').checked = true; // モーダルを開く
    } else {
      console.error('Input elements not found in the modal');
    }
  }
});