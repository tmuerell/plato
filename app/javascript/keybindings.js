import "mousetrap"

const staticKeybindings = {
  "/": (e) => { document.getElementById('global-search-input').focus(); e.preventDefault(); },
  "e": handleEditAction,
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