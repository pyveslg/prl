import { Controller } from "stimulus"
import { annotate } from 'rough-notation';

export default class extends Controller {
  static targets = ["highlight"]

  connect() {
    this.highlightTargets.forEach((element) => {
      const annotation = annotate(element, {
        type: 'highlight',
        color: '#FEF68E'
      });
      annotation.show();
    })
  }
}
