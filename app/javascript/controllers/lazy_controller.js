import { FetchRequest } from "@rails/request.js";

export default class extends ApplicationController {
  static targets = ["container", "htmlResponse"];
  static values = { url: String };

  async fetch() {
    if (this.hasHtmlResponseTarget) return;

    const request = new FetchRequest("get", this.urlValue);
    const response = await request.perform();

    if (response.ok) {
      const body = await response.html;
      this.containerTarget.innerHTML = body;
    }
  }

  disconnect() {
    if (this.hasHtmlResponseTarget) {
      this.htmlResponseTarget.remove();
    }
  }
}
