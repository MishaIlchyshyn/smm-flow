import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]
  static values = { initial: { type: Number, default: 0 } }

  connect() {
    this.showTab(this.initialValue)
  }

  switch(event) {
    const index = this.tabTargets.indexOf(event.currentTarget)
    this.showTab(index)
    const url = new URL(window.location)
    const param = event.currentTarget.dataset.tabsParam
    param ? url.searchParams.set("tab", param) : url.searchParams.delete("tab")
    history.replaceState({}, "", url)
  }

  showTab(index) {
    this.tabTargets.forEach((tab, i) => tab.classList.toggle("on", i === index))
    this.panelTargets.forEach((panel, i) => { panel.hidden = i !== index })
  }
}
