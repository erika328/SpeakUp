document.addEventListener('DOMContentLoaded', function() {
  const tabs = document.querySelectorAll('.tab');
  const urlParams = new URLSearchParams(window.location.search);
  const difficulty = urlParams.get('q[difficulty_eq]');

  // ページロード時にタブの状態を復元
  if (difficulty) {
    const activeTab = document.querySelector(`.tab[data-difficulty="${difficulty}"]`);
    if (activeTab) {
      activeTab.classList.add('tab-active');
    }
  } else {
    document.querySelector('.tab[data-difficulty=""]').classList.add('tab-active');
  }

  tabs.forEach(tab => {
    tab.addEventListener('click', function(event) {
      event.preventDefault();

      // すべてのタブから`tab-active`クラスを削除する
      tabs.forEach(t => t.classList.remove('tab-active'));

      // クリックされたタブに`tab-active`クラスを追加する
      this.classList.add('tab-active');

      // クリックされたタブに対応するクエリパラメーターを取得し、URLを更新する
      const queryParam = this.dataset.difficulty;
      const updatedUrl = queryParam ? `?q[difficulty_eq]=${queryParam}` : '';
      window.location.href = `${window.location.pathname}${updatedUrl}`;
    });
  });
});
