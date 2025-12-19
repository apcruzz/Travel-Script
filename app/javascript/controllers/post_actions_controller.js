import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "picker", "comments", "commentButton" ]

  connect() {
    this.hideTimeout = null
    this.hidePicker(true)
  }

  showPicker() {
    if (!this.hasPickerTarget) return
    this.clearHideTimeout()
    this.pickerTarget.classList.add("is-visible")
  }

  hidePicker(force = false) {
    if (!this.hasPickerTarget) return
    if (!force) {
      this.clearHideTimeout()
    }
    this.pickerTarget.classList.remove("is-visible")
  }

  scheduleHide() {
    this.clearHideTimeout()
    this.hideTimeout = setTimeout(() => this.hidePicker(true), 150)
  }

  cancelHide() {
    this.clearHideTimeout()
  }

  clearHideTimeout() {
    if (this.hideTimeout) {
      clearTimeout(this.hideTimeout)
      this.hideTimeout = null
    }
  }

  toggleComments() {
    if (!this.hasCommentsTarget) return
    const isHidden = this.commentsTarget.hasAttribute("hidden")
    if (isHidden) {
      this.commentsTarget.removeAttribute("hidden")
      this.commentButtonTargets.forEach((btn) => btn.classList.add("is-active"))
    } else {
      this.commentsTarget.setAttribute("hidden", "hidden")
      this.commentButtonTargets.forEach((btn) => btn.classList.remove("is-active"))
    }
  }
}
