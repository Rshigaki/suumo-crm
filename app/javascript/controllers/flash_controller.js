import { Controller } from "@hotwired/stimulus"

// Auto-dismisss flash messages after 5 seconds
export default class extends Controller {
    connect() {
        this.timeout = setTimeout(() => {
            this.dismiss()
        }, 5000)
    }

    dismiss() {
        this.element.classList.add("opacity-0")
        setTimeout(() => {
            this.element.remove()
        }, 500) // Wait for fade out transition
    }
}
