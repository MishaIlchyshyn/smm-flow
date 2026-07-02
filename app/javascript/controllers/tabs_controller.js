import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel", "label"]
  static values = { initial: { type: Number, default: 0 } }

  connect() {
    const param = new URLSearchParams(window.location.search).get("tab")
    const index = this.tabTargets.findIndex(t => t.dataset.tabsParam === param)
    this.showTab(index)
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
    if (this.hasLabelTarget) {
      this.labelTarget.textContent = this.tabTargets[index]?.textContent?.trim() ?? ""
    }
  }
}
