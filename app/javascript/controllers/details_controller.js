export default class extends ApplicationController {
  connect() {
    if (this.pageIsPreview) {
      this.element.open = false;
    }
  }

  async hideAfterSuccess(event) {
    const formData = await event.detail.formSubmission;
    const { success } = formData.result;

    if (success) {
      this.hide();
    }
  }

  hide(event = null) {
    event?.preventDefault();
    this.element.open = false;
  }
}
