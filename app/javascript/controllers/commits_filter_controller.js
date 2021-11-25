import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "username"]

  changeBatch() {
    if (this.hasUsernameTarget) {
      this.usernameTarget.value = ""
    }

    this.formTarget.submit()
  }

  changeUsername() {
    this.formTarget.submit()
  }
}
