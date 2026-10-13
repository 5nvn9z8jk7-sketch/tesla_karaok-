/**
 * Tesla Karaoké Party - Mode Free Style
 * Improvise sur un beat généré, avec effets vocaux et enregistrement
 */

class FreestyleMode {
    constructor(audioEngine) {
        this.audio = audioEngine;
        this.isActive = false;
        this.isRecording = false;
        this.micActive = false;
        this.currentBeat = 'hiphop';
        this.currentEffect = 'none';
        this.timer = 0;
        this.timerInterval = null;
        this.animationId = null;
        this.recordedBlob = null;

        // Éléments DOM
        this.el = {
            screen: document.getElementById('screen-freestyle'),
            timer: document.getElementById('freestyle-timer'),
            visualizer: document.getElementById('visualizer-freestyle'),
            lyricsHint: document.getElementById('freestyle-lyrics-hint'),
            micBtn: document.getElementById('btn-mic-freestyle'),
            recordBtn: document.getElementById('btn-record'),
            beatBtns: document.querySelectorAll('.btn-beat'),
            effectBtns: document.querySelectorAll('.btn-effect')
        };

        this.vizCtx = this.el.visualizer.getContext('2d');

        this.bindEvents();
    }

    bindEvents() {
        this.el.micBtn.addEventListener('click', () => this.toggleMic());
        this.el.recordBtn.addEventListener('click', () => this.toggleRecording());

        this.el.beatBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                this.el.beatBtns.forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                this.currentBeat = btn.dataset.beat;
                if (this.isActive) {
                    this.audio.startBeat(this.currentBeat);
                }
            });
        });

        this.el.effectBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                this.el.effectBtns.forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                this.currentEffect = btn.dataset.effect;
                this.audio.setEffect(this.currentEffect);
            });
        });
    }

    start() {
        this.isActive = true;
        this.timer = 0;
        this.updateTimer();

        // Démarrer le beat
        this.audio.init().then(() => {
            this.audio.startBeat(this.currentBeat);
        });

        // Démarrer le micro automatiquement
        this.toggleMic(true);

        // Timer
        this.timerInterval = setInterval(() => {
            this.timer++;
            this.updateTimer();
        }, 1000);

        this.animate();
    }

    toggleMic(force) {
        const newState = force !== undefined ? force : !this.micActive;
        this.micActive = newState;

        this.audio.toggleMic(newState).then(() => {
            this.el.micBtn.textContent = newState ? '🎤 Micro ON' : '🎤 Micro OFF';
            this.el.micBtn.classList.toggle('active', newState);
        }).catch(err => {
            console.error('Erreur micro:', err);
            this.micActive = false;
        });
    }

    toggleRecording() {
        if (!this.micActive) {
            this.el.lyricsHint.textContent = 'Active d\'abord le micro !';
            return;
        }

        if (!this.isRecording) {
            // Démarrer l'enregistrement
            if (this.audio.startRecording()) {
                this.isRecording = true;
                this.el.recordBtn.textContent = '⏹️ Stop';
                this.el.recordBtn.classList.add('recording');
                this.el.lyricsHint.textContent = '🔴 Enregistrement en cours... Parle, chante, rape !';
            }
        } else {
            // Arrêter et sauvegarder
            this.audio.stopRecording().then(blob => {
                this.isRecording = false;
                this.el.recordBtn.textContent = '⏺️ Record';
                this.el.recordBtn.classList.remove('recording');
                this.recordedBlob = blob;

                if (blob) {
                    const url = URL.createObjectURL(blob);
                    const duration = Math.round(this.timer);
                    this.el.lyricsHint.innerHTML = `
                        ✅ Enregistrement sauvegardé (${duration}s)
                        <a href="${url}" download="freestyle-${Date.now()}.webm" style="color: var(--accent); display: block; margin-top: 8px;">
                            ⬇️ Télécharger ton freestyle
                        </a>
                    `;
                }
            });
        }
    }

    updateTimer() {
        const minutes = Math.floor(this.timer / 60);
        const seconds = this.timer % 60;
        this.el.timer.textContent = `${minutes}:${String(seconds).padStart(2, '0')}`;
    }

    animate() {
        if (!this.isActive) return;

        this.drawVisualizer();
        this.animationId = requestAnimationFrame(() => this.animate());
    }

    drawVisualizer() {
        const canvas = this.el.visualizer;
        const ctx = this.vizCtx;
        const width = canvas.width;
        const height = canvas.height;

        // Fond avec dégradé
        const gradient = ctx.createLinearGradient(0, 0, 0, height);
        gradient.addColorStop(0, '#1a1a2e');
        gradient.addColorStop(1, '#0a0a0f');
        ctx.fillStyle = gradient;
        ctx.fillRect(0, 0, width, height);

        const data = this.audio.getFrequencyData();
        const barWidth = (width / data.length) * 2;
        let x = 0;

        for (let i = 0; i < data.length; i++) {
            const barHeight = (data[i] / 255) * height * 0.8;
            // Dégradé néon
            const hue = 280 + (i / data.length) * 80;
            ctx.fillStyle = `hsla(${hue}, 100%, 60%, ${0.4 + (data[i] / 255) * 0.6})`;
            ctx.fillRect(x, height - barHeight, barWidth - 1, barHeight);

            // Reflet
            ctx.fillStyle = `hsla(${hue}, 100%, 60%, 0.1)`;
            ctx.fillRect(x, height - barHeight - 4, barWidth - 1, 4);

            x += barWidth;
        }
    }

    quit() {
        this.isActive = false;
        if (this.animationId) {
            cancelAnimationFrame(this.animationId);
        }
        if (this.timerInterval) {
            clearInterval(this.timerInterval);
        }
        this.audio.stopMic();
        this.audio.stopBeat();
        return null;
    }
}

// Instance globale
window.FreestyleMode = FreestyleMode;
