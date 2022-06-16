function tomSelectInit(selector = ".tom-select-init") {
  document.querySelectorAll(selector).forEach((el) => {
    const settings = {};
    new TomSelect(el, settings);
  });
}
