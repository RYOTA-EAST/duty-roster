const reload = () => {
  const form = document.getElementById("check-form");
  form.addEventListener("submit", (e) => {
    window.opener.location.reload(true);
    setTimeout(() => _window.close(), 3000);
    // setTimeout('window.close();', 5000);
  });
};

window.addEventListener("load",reload)
