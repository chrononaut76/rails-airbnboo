import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggleableElement"]

  fire() {
    const formContainer = this.toggleableElementTarget;
    formContainer.classList.toggle("d-none");

    if (formContainer.classList.contains("d-none")) {
      formContainer.parentElement.style.height = null;
    } else {
      formContainer.parentElement.style.height = "500px"; // Adjust the height as needed
    }
  }
}
