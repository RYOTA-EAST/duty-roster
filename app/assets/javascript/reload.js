// htmlの読み込みが完了した時に
window.addEventListener('DOMContentLoaded', ()=>{
  // check-formを探す
  const form = document.getElementById("check-form");
  // form要素に新しい属性を追加
  form.setAttribute("target","nWin"); 
  // submitが押された時に
  form.addEventListener("submit", (e) => {
    // 送信動作を止める（子ウィンドウがリロードされないように）
    e.preventDefault();
    // 対象のtargetのある子ウィンドウをnWinに代入する
    const nWin=window.open("","nWin");
    // 送信する
    e.target.submit();
    // 親ウィンドウのリロード
    setTimeout(()=>location.reload(),100);
    // 子ウィンドウ(nWin)を閉じる
    setTimeout(()=>nWin.close(),200);
  });
});