// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

import "./tom-select.js";
import "./popper";
import "./bootstrap.min";

import tomSelectInit from "./tom_select_init";

document.addEventListener("turbo:load", () => {
  tomSelectInit();
});
