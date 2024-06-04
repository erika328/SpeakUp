document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('show-buttons').addEventListener('click', function() {
    document.getElementById('review-buttons').style.display = 'block';
    this.style.display = 'none';
  });

  document.getElementById('speak-button').addEventListener('click', function() {
    var text = document.querySelector('h2.text-3xl.font-semibold.my-5').innerText;
    var msg = new SpeechSynthesisUtterance(text);
    msg.lang = 'en-GB'; // UK Englishに設定
    window.speechSynthesis.speak(msg);
  });
});