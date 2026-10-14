/**
 * Tesla Karaoké Party - Mode Solo
 * Chante une chanson complète avec scoring en temps réel
 */

class SoloMode {
    constructor(audioEngine, scoringSystem) {
        this.audio = audioEngine;
        this.scoring = scoringSystem;
        this.lyricsParser = new LyricsParser();
        this.currentSong = null;
        this.isPlaying = false;
        this.animationId = null;
        this.activeLineIndex = -1;

        // Éléments DOM
        this.el = {
            screen: document.getElementById('screen-solo'),
            songTitle: document.getElementById('solo-song-title'),
            score: document.getElementById('solo-score'),
            lyricsDisplay: document.getElementById('lyrics-display'),
            progressBar: document.getElementById('progress-bar'),
            visualizer: document.getElementById('visualizer-solo'),
            feedback: document.getElementById('solo-feedback'),
            micBtn: document.getElementById('btn-mic-solo'),
            offsetMinus: document.getElementById('btn-offset-minus'),
            offsetPlus: document.getElementById('btn-offset-plus'),
            offsetDisplay: document.getElementById('offset-display')
        };

        this.vizCtx = this.el.visualizer.getContext('2d');
        this.micActive = false;
        this.offsetAdjust = 0;
        this.onEnd = null;

        this.bindEvents();
    }

    bindEvents() {
        this.el.micBtn.addEventListener('click', () => this.toggleMic());

        this.el.offsetMinus.addEventListener('click', () => this.adjustOffset(-1));
        this.el.offsetPlus.addEventListener('click', () => this.adjustOffset(1));

        this.scoring.onScoreUpdate = (score, percentage, combo) => {
            this.el.score.textContent = `Score: ${score} (${percentage}%)`;
        };

        this.scoring.onFeedback = (text, type) => {
            this.el.feedback.textContent = text;
            this.el.feedback.className = 'feedback' + (type ? ' ' + type : '');
        };
    }

    async start(song) {
        // Réinstaller les callbacks audio (écrasés par les autres modes)
        this.audio.onTimeUpdate = (currentTime, duration) => {
            this.updateProgress(currentTime, duration);
            this.updateLyrics(currentTime);
        };
        this.audio.onEnded = () => {
            this.endGame();
        };

        this.currentSong = song;
        this.el.songTitle.textContent = `${song.title} - ${song.artist}`;
        this.el.score.textContent = 'Score: 0';
        this.el.feedback.textContent = '';
        this.activeLineIndex = -1;
        this.offsetAdjust = 0;
        this.el.offsetDisplay.textContent = '0s';

        // Charger les paroles
        try {
            await this.lyricsParser.load(song.lyricsUrl);
        } catch (err) {
            console.error('Erreur chargement paroles:', err);
        }

        // Charger la musique
        try {
            await this.audio.loadMusic(song.audioUrl, song.fallbackAudioUrl);
        } catch (err) {
            console.error('Erreur chargement audio:', err);
            return false;
        }

        // Réinitialiser le scoring
        this.scoring.reset();
        this.scoring.start();

        // Démarrer la lecture
        this.audio.playMusic();
        this.isPlaying = true;
        this.animate();

        return true;
    }

    adjustOffset(seconds) {
        this.offsetAdjust += seconds;
        // Appliquer le décalage à toutes les lignes
        const lines = this.lyricsParser.getLines();
        lines.forEach(line => line.time += seconds);
        // Rafraîchir l'affichage
        this.activeLineIndex = -1; // force le re-render
        this.updateLyrics(this.audio.getCurrentTime());
        // Mettre à jour l'affichage de l'offset
        const totalOffset = this.offsetAdjust;
        this.el.offsetDisplay.textContent = (totalOffset > 0 ? '+' : '') + totalOffset + 's';
    }

    toggleMic() {
        this.micActive = !this.micActive;
        this.audio.toggleMic(this.micActive).then(() => {
            this.el.micBtn.textContent = this.micActive ? '🎤 Micro ON' : '🎤 Micro OFF';
            this.el.micBtn.classList.toggle('active', this.micActive);
        }).catch(err => {
            console.error('Erreur micro:', err);
            this.micActive = false;
            this.el.micBtn.textContent = '🎤 Micro OFF';
            this.el.micBtn.classList.remove('active');
        });
    }

    updateProgress(currentTime, duration) {
        if (duration > 0) {
            const percent = (currentTime / duration) * 100;
            this.el.progressBar.style.width = percent + '%';
        }
    }

    updateLyrics(currentTime) {
        const newActiveIndex = this.lyricsParser.getActiveLineIndex(currentTime);

        if (newActiveIndex !== this.activeLineIndex) {
            this.activeLineIndex = newActiveIndex;
            this.renderLyrics(currentTime);
        }

        // Mettre à jour le scoring
        const activeLine = this.lyricsParser.getActiveLine(currentTime);
        const lineProgress = this.lyricsParser.getLineProgress(currentTime);
        this.scoring.update(currentTime, activeLine, lineProgress);
    }

    renderLyrics(currentTime) {
        const lines = this.lyricsParser.getLines();
        if (lines.length === 0) return;

        const activeIndex = this.activeLineIndex;
        const html = [];

        // Ligne active
        if (activeIndex >= 0) {
            html.push(`<p class="lyric-line active">${this.escapeHtml(lines[activeIndex].text)}</p>`);
        } else {
            html.push(`<p class="lyric-line active">♪ ♪ ♪</p>`);
        }

        // Prochaines lignes
        const upcoming = this.lyricsParser.getUpcomingLines(currentTime, 2);
        for (const line of upcoming) {
            html.push(`<p class="lyric-line upcoming">${this.escapeHtml(line.text)}</p>`);
        }

        this.el.lyricsDisplay.innerHTML = html.join('');
    }

    animate() {
        if (!this.isPlaying) return;

        this.drawVisualizer();
        this.animationId = requestAnimationFrame(() => this.animate());
    }

    drawVisualizer() {
        const canvas = this.el.visualizer;
        const ctx = this.vizCtx;
        const width = canvas.width;
        const height = canvas.height;

        ctx.fillStyle = '#12121a';
        ctx.fillRect(0, 0, width, height);

        const data = this.audio.getFrequencyData();
        const barWidth = (width / data.length) * 2;
        let x = 0;

        for (let i = 0; i < data.length; i++) {
            const barHeight = (data[i] / 255) * height;
            const hue = (i / data.length) * 360;
            ctx.fillStyle = `hsl(${hue}, 80%, 50%)`;
            ctx.fillRect(x, height - barHeight, barWidth - 1, barHeight);
            x += barWidth;
        }
    }

    endGame() {
        this.isPlaying = false;
        this.scoring.stop();
        if (this.animationId) {
            cancelAnimationFrame(this.animationId);
        }
        this.audio.stopMic();
        this.audio.stopMusic();

        // Retourner les résultats
        const results = this.scoring.getResults();
        if (this.onEnd) this.onEnd(results);
        return results;
    }

    quit() {
        this.isPlaying = false;
        this.scoring.stop();
        if (this.animationId) {
            cancelAnimationFrame(this.animationId);
        }
        this.audio.stopMic();
        this.audio.stopMusic();
        return null;
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
}

// Instance globale
window.SoloMode = SoloMode;
