export default class extends ApplicationController {
  static targets = ["palette", "input"];
  static values = { default: String };

  initialize() {
    this.registerEvents();
    this.initializeDefaultHex();
    this.alwaysHex();
    this.onOutsideClick();
  }

  selectColor(event) {
    event.preventDefault();

    this.inputTarget.value = event.target.value;
    this.paletteTarget.hidden = true;
  }

  // private

  registerEvents() {
    ["click", "focus"].forEach((eventName) => {
      this.inputTarget.addEventListener(eventName, (event) => {
        this.paletteTarget.hidden = false;
      });
    });
  }

  initializeDefaultHex() {
    if (this.inputTarget.value.length) return;

    this.inputTarget.value = this.defaultValue;
  }

  alwaysHex() {
    this.inputTarget.addEventListener("input", () => {
      if (this.inputTarget.value.charAt(0) == "#") return;

      this.inputTarget.value = `#${this.inputTarget.value}`;
    });
  }

  onOutsideClick() {
    document.addEventListener("click", (event) => {
      if (this.element.contains(event.target)) return;

      this.paletteTarget.hidden = true;
    });
  }
}
