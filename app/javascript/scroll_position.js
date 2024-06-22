// ページが読み込まれたときの処理
document.addEventListener('DOMContentLoaded', () => {
  // スクロール位置の復元
  const scrollPos = sessionStorage.getItem('scrollPos');
  if (scrollPos) {
    window.scrollTo(0, parseInt(scrollPos));
    sessionStorage.removeItem('scrollPos');
  }

  // ページネーションボタンの取得とイベントリスナーの追加
  const paginationButtons = document.querySelectorAll('.pagination-button');
  paginationButtons.forEach(button => {
    button.addEventListener('click', () => {
      window.scrollTo(0, 0); // 最上部にスクロール
    });
  });
});

// ページがアンロードされる直前の処理
window.addEventListener('beforeunload', () => {
  sessionStorage.setItem('scrollPos', window.scrollY);
});
