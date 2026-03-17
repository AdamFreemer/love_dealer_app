import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "hiddenField"]

  toggle(event) {
    const button = event.currentTarget
    const serviceId = button.dataset.serviceId
    const isActive = button.classList.toggle("border-pk")
    button.classList.toggle("text-pk", isActive)
    button.classList.toggle("bg-pk/10", isActive)
    button.classList.toggle("text-muted", !isActive)

    const hiddenField = this.hiddenFieldTargets.find(f => f.dataset.serviceId === serviceId)
    if (hiddenField) {
      hiddenField.disabled = !isActive
      hiddenField.value = isActive ? serviceId : ""
    }
  }
}
