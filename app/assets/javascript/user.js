document.addEventListener("DOMContentLoaded", () => {
  const inputElement = document.getElementById("user_input");
  inputElement.addEventListener("keyup", () => {
    const keyword = document.getElementById("user_input").value;
    const XHR = new XMLHttpRequest();
    XHR.open("GET", `search/?keyword=${keyword}`, true);
    XHR.responseType = "json";
    XHR.send();
    XHR.onload = () => {
      const searchResult = document.getElementById("search-result");
      searchResult.innerHTML = "";
      if (XHR.response) {
        const userName = XHR.response.keyword;
        userName.forEach((user) => {
          const childElement = document.createElement("div");
          childElement.setAttribute("class", "child");
          childElement.setAttribute("id", user.id);
          childElement.innerHTML = user.nickname;
          searchResult.appendChild(childElement);

          const userResult = document.getElementById("duty-user")
          const clickElement = document.getElementById(user.id);
          clickElement.addEventListener("click", () => {
            // チェックボックスを入れる
            const check = document.createElement("input");
            check.setAttribute("name", "duty[user_ids][]");
            check.setAttribute("value", user.id);
            check.setAttribute("type", "checkbox");
            check.setAttribute("checked", "checked");
            userResult.appendChild(check);
            // 名前を入れる
            const nickname = document.createElement('span');
            nickname.textContent = user.nickname
            userResult.appendChild(nickname);
            clickElement.remove();
          });
        });
      };
    };
  });
});