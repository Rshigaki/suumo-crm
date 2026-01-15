import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["menu", "openIcon", "closeIcon"]

    connect() {
        this.close()
    }

    toggle() {
        if (this.menuTarget.classList.contains("hidden")) {
            this.open()
        } else {
            this.close()
        }
    }

    open() {
        this.menuTarget.classList.remove("hidden")
        this.openIconTarget.classList.add("hidden")
        this.closeIconTarget.classList.remove("hidden")
    }

    close() {
        this.menuTarget.classList.add("hidden")
        this.openIconTarget.classList.remove("hidden")
        this.closeIconTarget.classList.add("hidden")
    }
}
