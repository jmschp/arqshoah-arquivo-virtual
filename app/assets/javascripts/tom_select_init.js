function tomSelectInit(selector = ".tom-select-init") {
  document.querySelectorAll(selector).forEach((el) => {
    const settings = el.classList.contains("tom-select-location") ? locationFetchSettings() : {};
    new TomSelect(el, settings);
  });
}

function locationFetchSettings() {
  return {
    loadThrottle: 500,
    valueField: "display_name",
    labelField: "display_name",
    searchField: "display_name",
    load: function (query, callback) {
      params = {
        email: "leer@usp.br",
        format: "jsonv2",
        limit: 5,
        "accept-language": "pt",
        q: query,
      };

      const query_params = [];
      for (let key in params) {
        query_params.push(`${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`);
      }

      const url = `https://nominatim.openstreetmap.org/search?${query_params.join("&")}`;

      fetch(url)
        .then((response) => response.json())
        .then((json) => callback(json))
        .catch(() => callback());
    },
  };
}
