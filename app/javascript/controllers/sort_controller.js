import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["row"]

  sort(event) {
    const column = event.currentTarget.dataset.column
    const type = event.currentTarget.dataset.type

    const rows = this.rowTargets.slice()

    rows.sort((a, b) => {
      let aValue = a.dataset[column]
      let bValue = b.dataset[column]

      if (type === "number") {
        aValue = parseFloat(aValue)
        bValue = parseFloat(bValue)
      } else if (type === "date") {
        aValue = new Date(aValue)
        bValue = new Date(bValue)
      } else {
        aValue = aValue.toLowerCase()
        bValue = bValue.toLowerCase()
      }

      if (aValue < bValue) return -1
      if (aValue > bValue) return 1
      return 0
    })

    const tbody = this.element.querySelector("tbody")
    rows.forEach(row => tbody.appendChild(row))
  }
}
