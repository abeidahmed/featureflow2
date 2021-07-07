const customElements = require.context(".", true, /_element\.js$/);

document.addEventListener("turbo:load", () => {
  customElements.keys().forEach(customElements);
});
