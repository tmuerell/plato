import "mousetrap"

const staticKeybindings = {
  "/": (e) => { document.getElementById('global-search-input').focus(); e.preventDefault(); },
  "e": handleEditAction,
  'j': handleNextSelectable,
  'down': handleNextSelectable,
  'k': handlePreviousSelectable,
  'up': handlePreviousSelectable,
  'enter': handleEnter,
  'n t': () => window.location.replace('/tickets/new'),
  'g d': () => window.location.replace('/'),
  'g i': () => window.location.replace('/tickets/inbox'),
};

document.addEventListener('DOMContentLoaded', function () {
    handleKeyBindings();
}, false);

document.addEventListener('page:change', function () {
    handleKeyBindings();
}, false);

function handleKeyBindings() {
  // As turbolinks does not refresh the page, some old keybindings could be still present.
  // Therefore a reset is required.
  Mousetrap.reset();

  let keybindings = staticKeybindings;

  // Hotkey binding to links with 'data-keybinding' attribute
  // Navigate link when hotkey pressed
  document.querySelectorAll('a[data-keybinding]').forEach((el) => {
    let bindedKey = el.dataset.keybinding;
    if (typeof(bindedKey) == 'number') {
      bindedKey = bindedKey.toString() ;
    }

    keybindings[bindedKey] = function (e) {
      if(typeof(Turbolinks) == 'undefined') {
        // Emulate click if turbolinks defined
        el.click()
      } else {
        // Use turbolinks to go to URL
        Turbolinks.visit(el.href);
      }
    };
  });

  // Hotkey binding to inputs with 'data-keybinding' attribute
  // Focus input when hotkey pressed
  document.querySelectorAll('input[data-keybinding]').forEach((el) => {
    let bindedKey = el.dataset.keybinding;
    if (typeof(bindedKey) == 'number') {
      bindedKey = bindedKey.toString() ;
    }

    keybindings[bindedKey] = function (e) {
      el.focus();
      if(e.preventDefault) {
        e.preventDefault()
      } else {;
        e.returnValue = false;
      }
    };
  });

  // Do bindings
  for (let binding in keybindings) {
    Mousetrap.bind(binding, keybindings[binding]);
  }
}

function handleEditAction() {
  let elements = document.querySelectorAll("[data-edit-action");
  if (elements.length == 1) {
    window.location.replace(elements[0].dataset["editAction"]);
  }
}

function handleNextSelectable() {
  var element = document.querySelector(".selectable.selected");

  if (element === null) {
    element = document.querySelector(".selectable");
    element.classList.toggle("selected");
    return;
  }

  let selectables = Array.from(document.querySelectorAll(".selectable"));
  let nextIndex = (selectables.indexOf(element) + 1) % selectables.length;
  let next = selectables[nextIndex]
  element.classList.toggle("selected");
  next.classList.toggle("selected");
}

function handlePreviousSelectable() {
  var element = document.querySelector(".selectable.selected");
  if (element === null) {
    return null;
  }

  let selectables = Array.from(document.querySelectorAll(".selectable"));

  let index = selectables.indexOf(element);
  let nextIndex = index == 0 ? selectables.length -1 : (index - 1) % selectables.length;

  let next = selectables[nextIndex]
  element.classList.toggle("selected");
  next.classList.toggle("selected");
}

function handleEnter() {
  var element = document.querySelector(".selectable.selected");

  if (element === null) {
    return;
  }

  var url = element.dataset["uri"];

  if (url !== undefined) {
    window.location.replace(url);
  }
}
