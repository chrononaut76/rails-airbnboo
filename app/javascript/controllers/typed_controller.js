import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Connects to data-controller="typed"
export default class extends Controller {
  static values = { strings: Array}

  connect() {
     const typed = new Typed(this.element, {
      strings: ["Welcome to AirbnBoo"],
      typeSpeed: 40,
      loopCount: 1
    })
  }



}
