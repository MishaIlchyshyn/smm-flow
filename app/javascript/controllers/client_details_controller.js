import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["view", "form", "actions", "confirm"]

  edit() {
    this.keep()
    this.viewTarget.hidden = true
    this.formTarget.hidden = false
    this.formTarget.querySelector("input:not([type=hidden])")?.focus()
  }

  cancel() {
    this.formTarget.querySelector("form")?.reset()
    this.formTarget.hidden = true
    this.viewTarget.hidden = false
  }

  askDelete() {
    this.actionsTarget.hidden = true
    this.confirmTarget.hidden = false
  }

  keep() {
    this.confirmTarget.hidden = true
    this.actionsTarget.hidden = false
  }
}
