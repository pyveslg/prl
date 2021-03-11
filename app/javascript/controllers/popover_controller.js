import { Controller } from "stimulus"
import tippy from 'tippy.js'

export default class extends Controller {
  static targets = ["tooltip"]

  connect() {
    this.tooltipTargets.forEach((tooltip) => {
      tippy(tooltip, {
        content: `${tooltip.alt}`,
        placement: "bottom",
      });
    });
  }
}
