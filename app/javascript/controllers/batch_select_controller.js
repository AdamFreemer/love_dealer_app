import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selectAll", "checkbox", "batchActions", "form"]

  connect() {
    this.updateUI()
  }

  toggleAll() {
    const checked = this.selectAllTarget.checked
    this.checkboxTargets.forEach(cb => cb.checked = checked)
    this.updateUI()
  }

  toggleOne() {
    const allChecked = this.checkboxTargets.every(cb => cb.checked)
    this.selectAllTarget.checked = allChecked
    this.updateUI()
  }

  updateUI() {
    const count = this.checkboxTargets.filter(cb => cb.checked).length
    if (count > 0) {
      this.batchActionsTarget.classList.remove("hidden")
      this.batchActionsTarget.querySelector("[data-count]").textContent = `Delete ${count} selected`
    } else {
      this.batchActionsTarget.classList.add("hidden")
    }
  }

  submitBatch(event) {
    const count = this.checkboxTargets.filter(cb => cb.checked).length
    if (!confirm(`Are you sure you want to delete ${count} customer(s)? This action can be undone by an administrator.`)) {
      event.preventDefault()
      return
    }

    const form = this.formTarget
    // Clear any existing hidden inputs
    form.querySelectorAll("input[name='customer_ids[]']").forEach(el => el.remove())

    this.checkboxTargets.filter(cb => cb.checked).forEach(cb => {
      const input = document.createElement("input")
      input.type = "hidden"
      input.name = "customer_ids[]"
      input.value = cb.value
      form.appendChild(input)
    })

    form.requestSubmit()
  }
}
