document.addEventListener('DOMContentLoaded', function() {
  const tabs = document.querySelectorAll('.tab');

  tabs.forEach(tab => {
    tab.addEventListener('click', function() {
      // すべてのタブから`tab-active`クラスを削除する
      tabs.forEach(t => t.classList.remove('tab-active'));

      // クリックされたタブに`tab-active`クラスを追加する
      this.classList.add('tab-active');
    });
  });
});