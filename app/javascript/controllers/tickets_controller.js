import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "watchers", "linkedTickets" ]

  connect() {
  }

  toggleWatchers() {
    this.watchersTarget.classList.toggle("folded");
  }

  toggleLinkedTickets() {
    this.linkedTicketsTarget.classList.toggle("folded");
  }
}
