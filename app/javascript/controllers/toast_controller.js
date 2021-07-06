export default class extends ApplicationController {
  connect() {
    if (this.pageIsPreview) {
      this.element.remove();
    }

    this.element.classList.add("toast--animateIn");

    this.timerId = setTimeout(() => {
      this.hide();
    }, 4000);
  }

  hide(event = null) {
    event?.preventDefault();
    this.element.classList.replace("toast--animateIn", "toast--animateOut");
  }

  disconnect() {
    if (this.timerId) {
      clearTimeout(this.timerId);
    }
  }
}
