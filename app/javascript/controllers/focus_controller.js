import { nextFrame } from "../helpers";

export default class extends ApplicationController {
  static targets = ["focusable"];

  async focusElement() {
    await nextFrame();
    this.focusableTarget?.focus();
  }
}
