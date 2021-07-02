import { Controller } from "stimulus";

export default class extends Controller {
  get pageIsPreview() {
    return document.documentElement.hasAttribute("data-turbo-preview");
  }
}
