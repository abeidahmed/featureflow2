export default class extends ApplicationController {
  connect() {
    if (this.pageIsPreview) {
      return this.hide();
    }

    this.element.setAttribute("role", "dialog");
    this.element.setAttribute("aria-modal", "true");

    const summary = this.element.querySelector("summary");
    summary.setAttribute("role", "button");

    this.element.addEventListener("toggle", this.toggle.bind(this));
  }

  async hideAfterSuccess(event) {
    const formData = await event.detail.formSubmission;
    const { success } = formData.result;

    if (!success) return;
    this.hide();
  }

  hide(event = null) {
    event?.preventDefault();
    this.element.open = false;
  }

  // private

  toggle(event) {
    const details = event.currentTarget;
    if (!details.hasAttribute("data-modal")) return;

    if (details.hasAttribute("open")) {
      details.addEventListener("keydown", keydown);
    } else {
      details.removeEventListener("keydown", keydown);
      this.resetForms();
    }
  }

  resetForms() {
    for (const form of this.element.querySelectorAll("form")) {
      form.reset();
    }
  }
}

function keydown(event) {
  if (event.key === "Escape" || event.key === "Esc") {
    event.currentTarget.removeAttribute("open");
  }
}
