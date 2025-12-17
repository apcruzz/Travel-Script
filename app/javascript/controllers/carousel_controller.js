import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "track", "slide", "nav", "dot" ]

  connect() {
    this.index = 0
    this.showCurrent()
    this.toggleNav()
  }

  next(event) {
    event.preventDefault()
    if (this.slideCount <= 1) return
    this.index = (this.index + 1) % this.slideCount
    this.showCurrent()
  }

  prev(event) {
    event.preventDefault()
    if (this.slideCount <= 1) return
    this.index = (this.index - 1 + this.slideCount) % this.slideCount
    this.showCurrent()
  }

  jump(event) {
    event.preventDefault()
    const targetIndex = parseInt(event.currentTarget.dataset.carouselIndex, 10)
    if (Number.isNaN(targetIndex) || targetIndex === this.index) return
    this.index = targetIndex
    this.showCurrent()
  }

  showCurrent() {
    this.slideTargets.forEach((slide, idx) => {
      slide.classList.toggle("is-active", idx === this.index)
    })

    this.dotTargets.forEach((dot, idx) => {
      dot.classList.toggle("is-active", idx === this.index)
    })
  }

  toggleNav() {
    const shouldHide = this.slideCount <= 1
    this.navTargets.forEach((nav) => {
      nav.classList.toggle("is-hidden", shouldHide)
      nav.disabled = shouldHide
    })
    this.dotTargets.forEach((dot) => {
      dot.classList.toggle("is-hidden", shouldHide)
      dot.disabled = shouldHide
    })
  }

  get slideCount() {
    return this.slideTargets.length
  }
}
