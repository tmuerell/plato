// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import { HighlightJS } from "highlight.js"

document.addEventListener('turbo:load', (event) => {
    console.log("High")
    HighlightJS.highlightAll()
});