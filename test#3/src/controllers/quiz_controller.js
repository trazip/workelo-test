import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  static targets = ['panel', 'answer']
  static values = { index: Number }

  initialize() {
    this.showCurrentPanel();
  }
  
  select(event) {
    event.currentTarget.classList.toggle('selected');
    event.currentTarget.children[0].classList.toggle('selected');
    const answerIndex = parseInt(event.currentTarget.dataset.answerIndex);
    this.answerTargets[answerIndex].classList.toggle('d-none');
  }

  next() {
    this.indexValue++;
  }

  previous() {
    this.indexValue--;
  }

  indexValueChanged() {
    this.showCurrentPanel();
  }

  showCurrentPanel() {
    this.panelTargets.forEach((element, index) => {
      element.hidden = index != this.indexValue
    });
  }
}
