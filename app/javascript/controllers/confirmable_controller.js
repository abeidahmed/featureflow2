export default class extends ApplicationController {
  static targets = ["inputField", "submitBtn"];
  static values = { confirm: String };

  connect() {
    if (this.inputFieldTarget.value !== this.confirmValue) {
      this.submitBtnTarget.disabled = true;
    }
  }

  verify(event) {
    if (event.target.value === this.confirmValue) {
      this.submitBtnTarget.disabled = false;
    } else {
      this.submitBtnTarget.disabled = true;
    }
  }
}
