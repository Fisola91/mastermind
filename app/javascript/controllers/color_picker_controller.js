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

    const currentNumber = currentCell.dataset.number
    const input = document.querySelector(`.guess-input[data-number='${currentNumber}']`)
    input.value = color.toUpperCase()

    const guessCheck = document.querySelector(".guess-check")
    if (currentNumber < 3) {
      guessCheck.disabled=true
    } else {
      guessCheck.disabled=false
    }

    const nextCell = currentCell.nextElementSibling
    if (!nextCell) return

    nextCell.classList.add("current-cell")
  }

  undo() {
    const currentCell = document.querySelector(".current-cell")
    let lastCell
    if (!currentCell) {
      lastCell = document.querySelector(".current-attempt .guess-cell:last-child")
    } else {
      lastCell = currentCell.previousSibling
    }
    if (!lastCell) return

    const backgroundClasses = Array.from(lastCell.classList).filter(className => className.startsWith("bg-"))
    backgroundClasses.forEach(className => lastCell.classList.remove(className))

    if (currentCell) {
      currentCell.classList.remove('current-cell')
    }
    lastCell.classList.add('current-cell')
  }
}
