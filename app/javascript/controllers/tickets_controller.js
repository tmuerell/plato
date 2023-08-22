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

  copyToClipboard(e) {
    e.preventDefault();
    let element = e.target.closest("[data-ticket-identifier]");
    if (element === undefined) {
      console.error("ticket identifier not found");
      return
    }

    let ticketIdentifier = element.dataset['ticketIdentifier'];
    if (ticketIdentifier === undefined) {
      console.error("ticket identifier not found");
      return
    }

    navigator.clipboard.writeText(ticketIdentifier);
  }
}
