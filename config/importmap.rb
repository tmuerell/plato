# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "popper", to: 'popper.js', preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin "highlight.js", to: "https://ga.jspm.io/npm:highlight.js@11.8.0/es/index.js"
pin "choices.js", to: "https://ga.jspm.io/npm:choices.js@10.2.0/public/assets/scripts/choices.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "mousetrap", to: "https://ga.jspm.io/npm:mousetrap@1.6.5/mousetrap.js"

# Own files
pin "keybindings"
