// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import {HighlightJS} from "highlight.js"
import Choices from "choices.js"

import "keybindings"

document.addEventListener('turbo:load', (event) => {
    const highlightedItems = document.querySelectorAll(".js-choice");
    highlightedItems.forEach(function (userItem) {
        new Choices(userItem, {
            removeItemButton: true,
        });
    });
    HighlightJS.highlightAll()
});