import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this._onKey = (e) => { if (e.key === "Escape") this.close() }
    this._onOutside = (e) => { if (!this.element.contains(e.target)) this.close() }
    window.addEventListener("keydown", this._onKey)
    window.addEventListener("click", this._onOutside, true)
  }

  disconnect() {
    window.removeEventListener("keydown", this._onKey)
    window.removeEventListener("click", this._onOutside, true)
  }

  toggle(e) {
    e.stopPropagation()
    this.element.classList.toggle("open")
  }

  close() {
    this.element.classList.remove("open")
  }
}
