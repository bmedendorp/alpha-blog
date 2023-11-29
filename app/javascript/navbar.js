function toggle_menu() {
  document.getElementById("menu").classList.toggle("hidden");
}

document.getElementById("menu_open").addEventListener("click", toggle_menu);
document.getElementById("menu_close").addEventListener("click", toggle_menu);
