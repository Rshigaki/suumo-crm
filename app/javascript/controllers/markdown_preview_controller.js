import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "preview", "writeBtn", "previewBtn"]

    connect() {
        this.showWrite()
    }

    showWrite(e) {
        if (e) e.preventDefault()
        this.inputTarget.classList.remove("hidden")
        this.previewTarget.classList.add("hidden")
        this.toggleTabs(this.writeBtnTarget, this.previewBtnTarget)
    }

    async showPreview(e) {
        if (e) e.preventDefault()
        this.inputTarget.classList.add("hidden")
        this.previewTarget.classList.remove("hidden")
        this.toggleTabs(this.previewBtnTarget, this.writeBtnTarget)

        const content = this.inputTarget.value
        this.previewTarget.innerHTML = '<div class="animate-pulse text-gray-500">Loading preview...</div>'

        try {
            const token = document.querySelector('meta[name="csrf-token"]').content
            const response = await fetch("/preview_markdown", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRF-Token": token
                },
                body: JSON.stringify({ content: content })
            })

            if (response.ok) {
                const html = await response.text()
                this.previewTarget.innerHTML = html
                // Add prose class deeply if needed, but wrapper has it
            } else {
                this.previewTarget.innerHTML = '<span class="text-red-500">Failed to load preview.</span>'
            }

        } catch (error) {
            console.error(error)
            this.previewTarget.innerHTML = '<span class="text-red-500">Error loading preview.</span>'
        }
    }

    toggleTabs(active, inactive) {
        active.classList.add("bg-indigo-100", "text-indigo-700", "border-indigo-200")
        active.classList.remove("bg-white", "text-gray-500", "border-transparent", "hover:text-gray-700", "hover:bg-gray-50")

        inactive.classList.add("bg-white", "text-gray-500", "border-transparent", "hover:text-gray-700", "hover:bg-gray-50")
        inactive.classList.remove("bg-indigo-100", "text-indigo-700", "border-indigo-200")
    }
}
