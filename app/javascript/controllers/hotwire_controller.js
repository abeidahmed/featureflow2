import { formErrorHandler } from "../helpers";

export default class extends ApplicationController {
  static targets = ["errorContainer"];

  async onSubmit(event) {
    const formData = await event.detail.formSubmission;
    const { success, fetchResponse } = formData.result;

    if (success) return;

    const res = await fetchResponse.responseText;
    const { errors } = JSON.parse(res);

    this.errorContainerTargets.forEach((errorTarget) => {
      const errorType = errorTarget.dataset.formError;

      const errorMsg = formErrorHandler({
        errors,
        type: errorType,
      });
      errorTarget.innerHTML = errorMsg || "";
    });
  }
}
