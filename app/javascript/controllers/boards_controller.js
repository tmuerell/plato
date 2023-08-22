import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="boards"
export default class extends Controller {
  static targets = [ "board", "boardColumn" ]

  connect() {
  }

  dragstart(e) {
    e.dataTransfer.dropEffect = "move";
    e.dataTransfer.setData("text/plain", e.target.id);


    let validTransitions = JSON.parse(e.target.closest(".kanban-col").dataset["validTransitions"]);
    this.boardColumnTargets.forEach(column => {
      if (validTransitions.includes(column.dataset["status"])) {
        column.classList.add("droppable");

        column.addEventListener("dragenter", dragenter);
        column.addEventListener("dragover", dragover);
        column.addEventListener("drop", drop);
      } else {
        column.classList.add("undroppable");
      }
    });
  }

  dragend(e) {
    e.preventDefault();
    this.boardColumnTargets.forEach(column => {
      column.classList.remove("droppable");
      column.classList.remove("undroppable");
    });

    this.boardColumnTargets.forEach(column => {
      column.removeEventListener("dragenter", dragenter);
      column.removeEventListener("dragover", dragover);
      column.removeEventListener("drop", drop);
    });
  }

}

function dragenter(e) {
  e.preventDefault();
}

function dragover(e) {
  e.preventDefault();
}

function drop(e) {
  e.preventDefault();

  let ticketId = e.dataTransfer.getData("text/plain");
  let newStatus = e.target.closest(".kanban-col").dataset["status"];
  let ticket = document.getElementById(ticketId);
  let ticketUri = new URL(ticket.dataset["uri"]);
  ticketUri.searchParams.append("ticket[status]", newStatus);
  let csrfToken = document.querySelector("[name='csrf-token']").content

  let params = {
    method: "PATCH",
    mode: 'cors', // no-cors, *cors, same-origin
    cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
    credentials: 'same-origin', // include, *same-origin, omit
    headers: {
      'X-CSRF-Token': csrfToken
    },
  };
  fetch(ticketUri, params)
    .then(response => {
        if (response.ok || response.redirected) {
          let target = e.target.closest(".kanban-col");
          target.appendChild(ticket);
        }
     });
}
