import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["timer", "startBtn", "stopBtn", "status"]

    connect() {
        this.startTime = null
        this.timerInterval = null
        this.start()
    }

    start(event) {
        // In a real app, access microphone here
        this.startTime = Date.now()
        this.timerInterval = setInterval(() => {
            this.updateTimer()
        }, 1000)

        this.startBtnTarget.classList.add("hidden")
        this.stopBtnTarget.classList.remove("hidden")
        this.statusTarget.textContent = "Recording..."
    }

    stop(event) {
        clearInterval(this.timerInterval)
        // In a real app, stop recording and upload blob

        this.stopBtnTarget.classList.add("hidden")
        this.statusTarget.textContent = "Processing..."

        // Simulate upload/processing delay
        setTimeout(() => {
            // Trigger form submission or redirect
            this.element.closest("form").submit()
        }, 1000)
    }

    updateTimer() {
        const diff = Math.floor((Date.now() - this.startTime) / 1000)
        const minutes = Math.floor(diff / 60).toString().padStart(2, '0')
        const seconds = (diff % 60).toString().padStart(2, '0')
        this.timerTarget.textContent = `${minutes}:${seconds}`
    }
}
