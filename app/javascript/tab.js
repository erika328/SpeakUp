document.addEventListener('DOMContentLoaded', function() {
  const tabs = document.querySelectorAll('.tab');
  const urlParams = new URLSearchParams(window.location.search);
  const difficulty = urlParams.get('q[difficulty_eq]');
  const likedByUser = urlParams.get('q[liked_by_user]');

  // ページロード時にタブの状態を復元
  if (difficulty) {
    const activeTab = document.querySelector(`.tab[data-difficulty="${difficulty}"]`);
    if (activeTab) {
      activeTab.classList.add('tab-active');
    }
  } else if (likedByUser) {
    const activeTab = document.querySelector(`.tab[data-liked-by-user="${likedByUser}"]`);
    if (activeTab) {
      activeTab.classList.add('tab-active');
    }
  } else {
    document.querySelector('.tab[data-difficulty="Beginner"]').classList.add('tab-active');
  }

  tabs.forEach(tab => {
    tab.addEventListener('click', function(event) {
      event.preventDefault();

      // すべてのタブから`tab-active`クラスを削除する
      tabs.forEach(t => t.classList.remove('tab-active'));

      // クリックされたタブに`tab-active`クラスを追加する
      this.classList.add('tab-active');

      // クリックされたタブに対応するクエリパラメーターを取得し、URLを更新する
      let updatedUrl = new URL(window.location);
      if (this.dataset.difficulty) {
        updatedUrl.searchParams.set('q[difficulty_eq]', this.dataset.difficulty);
        updatedUrl.searchParams.delete('q[liked_by_user]');
      } else if (this.dataset.likedByUser) {
        updatedUrl.searchParams.set('q[liked_by_user]', this.dataset.likedByUser);
        updatedUrl.searchParams.delete('q[difficulty_eq]');
      }

      window.location.href = updatedUrl;
    });
  });
});