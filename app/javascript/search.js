document.addEventListener('DOMContentLoaded', function() {
  const selectElement = document.getElementById('part-of-speech-select');

  if (selectElement) {
    selectElement.addEventListener('change', function() {
      console.log("Form is being submitted");
      this.form.submit();
    });
  }
});