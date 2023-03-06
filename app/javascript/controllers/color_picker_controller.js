import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  click() {
    const color = event.target.dataset.color
    const currentAttemptRow = document.querySelector(".current-attempt")
    const currentCell = document.querySelector(".current-cell")
    if (!currentCell) return

    currentCell.classList.remove("bg-black")
    currentCell.classList.add(`bg-${color}`)
    currentCell.classList.remove("current-cell")

    const nextCell = currentCell.nextElementSibling
    if (!nextCell) return

    nextCell.classList.add("current-cell")
  }
}
