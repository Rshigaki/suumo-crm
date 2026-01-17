import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["timer", "startBtn", "stopBtn", "status", "transcriptInput", "liveTranscript"]

    connect() {
        this.startTime = null
        this.timerInterval = null
        this.isRecording = false
        this.recognition = null

        this.initializeSpeechRecognition()

        // Auto-start recording when the controller connects (view loads)
        this.start()
    }

    initializeSpeechRecognition() {
        if ('webkitSpeechRecognition' in window || 'SpeechRecognition' in window) {
            const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition
            this.recognition = new SpeechRecognition()
            this.recognition.continuous = true
            this.recognition.interimResults = true
            this.recognition.lang = 'ja-JP'

            this.recognition.onresult = (event) => {
                let fullText = ""
                for (let i = 0; i < event.results.length; i++) {
                    fullText += event.results[i][0].transcript
                }

                if (this.hasTranscriptInputTarget) {
                    this.transcriptInputTarget.value = fullText
                }
                if (this.hasLiveTranscriptTarget) {
                    this.liveTranscriptTarget.textContent = fullText || "（会話を認識中...）"
                }
            }

            this.recognition.onerror = (event) => {
                console.error("Speech recognition error", event.error)
                this.statusTarget.textContent = `Error: ${event.error}`
            }

            this.recognition.onend = () => {
                // If we are supposed to be recording but it stopped (e.g. silence), restart it
                if (this.isRecording) {
                    try {
                        this.recognition.start()
                    } catch (e) {
                        // Ignore if already started
                    }
                }
            }
        } else {
            this.statusTarget.textContent = "お使いのブラウザは音声認識に対応していません。"
            this.statusTarget.classList.add("text-red-600")
        }
    }

    start(event) {
        if (this.isRecording) return

        this.isRecording = true
        this.startTime = Date.now()
        this.timerInterval = setInterval(() => {
            this.updateTimer()
        }, 1000)

        if (this.hasStartBtnTarget) this.startBtnTarget.classList.add("hidden")
        if (this.hasStopBtnTarget) this.stopBtnTarget.classList.remove("hidden")
        if (this.hasStatusTarget) this.statusTarget.textContent = "録音中 (会話を認識しています...)"

        if (this.recognition) {
            try {
                this.recognition.start()
            } catch (e) {
                console.log("Recognition start error (likely already running)", e)
            }
        }
    }

    stop(event) {
        this.isRecording = false
        if (this.timerInterval) clearInterval(this.timerInterval)

        if (this.recognition) {
            this.recognition.stop()
        }

        if (this.hasStopBtnTarget) this.stopBtnTarget.classList.add("hidden")
        if (this.hasStatusTarget) this.statusTarget.textContent = "保存処理中..."

        // Small delay to ensure final results are processed
        setTimeout(() => {
            if (this.element.tagName === "FORM") {
                this.element.submit()
            } else {
                // If controller is on a wrapper div, find the form inside
                const form = this.element.querySelector("form")
                if (form) form.requestSubmit()
            }
        }, 800)
    }

    updateTimer() {
        const diff = Math.floor((Date.now() - this.startTime) / 1000)
        const minutes = Math.floor(diff / 60).toString().padStart(2, '0')
        const seconds = (diff % 60).toString().padStart(2, '0')
        if (this.hasTimerTarget) {
            this.timerTarget.textContent = `${minutes}:${seconds}`
        }
    }
}
