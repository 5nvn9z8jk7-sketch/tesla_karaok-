/**
 * Tesla Karaoké Party - Mode Duel
 * 2 joueurs s'affrontent, chacun chante une partie à tour de rôle
 */

class DuelMode {
    constructor(audioEngine) {
        this.audio = audioEngine;
        this.lyricsParser = new LyricsParser();
        this.currentSong = null;
        this.isPlaying = false;
        this.animationId = null;
        this.activeLineIndex = -1;
        this.currentPlayer = 1; // 1 ou 2
        this.scores = { p1: 0, p2: 0 };
        this.maxScores = { p1: 0, p2: 0 };
        this.lineScores = { p1: [], p2: [] };
        this.playerMicActive = { p1: false, p2: false };
        this.lineAssignments = []; // Quelle ligne est assignée à quel joueur

        // Éléments DOM
        this.el = {
            screen: document.getElementById('screen-duel'),
            songTitle: document.getElementById('duel-song-title'),
            lyricsDisplay: document.getElementById('duel-lyrics'),
            progressBar: document.getElementById('progress-bar-duel'),
            turnIndicator: document.getElementById('duel-turn'),
            scoreP1: document.getElementById('score-p1'),
            scoreP2: document.getElementById('score-p2'),
            indicatorP1: document.getElementById('indicator-p1'),
            indicatorP2: document.getElementById('indicator-p2'),
            panelP1: document.getElementById('panel-p1'),
            panelP2: document.getElementById('panel-p2'),
            vizP1: document.getElementById('visualizer-p1'),
            vizP2: document.getElementById('visualizer-p2'),
            micBtnP1: document.getElementById('btn-mic-p1'),
            micBtnP2: document.getElementById('btn-mic-p2')
        };

        this.vizCtxP1 = this.el.vizP1.getContext('2d');
        this.vizCtxP2 = this.el.vizP2.getContext('2d');
        this.onEnd = null;

        this.bindEvents();
    }

    bindEvents() {
        this.el.micBtnP1.addEventListener('click', () => this.toggleMic(1));
        this.el.micBtnP2.addEventListener('click', () => this.toggleMic(2));

        this.audio.onTimeUpdate = (currentTime, duration) => {
            this.updateProgress(currentTime, duration);
            this.updateGame(currentTime);
        };

        this.audio.onEnded = () => {
            this.endGame();
        };
    }

    async start(song) {
        this.currentSong = song;
        this.el.songTitle.textContent = `${song.title} - ${song.artist}`;
        this.scores = { p1: 0, p2: 0 };
        this.maxScores = { p1: 0, p2: 0 };
        this.lineScores = { p1: [], p2: [] };
        this.currentPlayer = 1;
        this.activeLineIndex = -1;

        this.updateScoreDisplay();
        this.updateTurnIndicator();

        // Charger les paroles
        try {
            await this.lyricsParser.load(song.lyricsUrl);
        } catch (err) {
            console.error('Erreur chargement paroles:', err);
        }

        // Assigner les lignes aux joueurs (alternance)
        this.assignLinesToPlayers();

        // Charger la musique
        try {
            await this.audio.loadMusic(song.audioUrl);
        } catch (err) {
            console.error('Erreur chargement audio:', err);
            return false;
        }

        // Démarrer
        this.audio.playMusic();
        this.isPlaying = true;
        this.animate();

        return true;
    }

    assignLinesToPlayers() {
        const lines = this.lyricsParser.getLines();
        this.lineAssignments = lines.map((_, index) => index % 2 === 0 ? 1 : 2);
    }

    toggleMic(player) {
        const key = 'p' + player;
        this.playerMicActive[key] = !this.playerMicActive[key];

        // Pour l'instant, on ne gère qu'un seul micro actif à la fois
        // (la plupart des voitures n'ont qu'un micro)
        // On switch le micro actif vers le joueur courant
        if (this.playerMicActive[key]) {
            this.audio.toggleMic(true).then(() => {
                this.el.micBtnP1.textContent = '🎤 J1 ON';
                this.el.micBtnP2.textContent = '🎤 J2 ON';
                this.el.micBtnP1.classList.toggle('active', this.currentPlayer === 1);
                this.el.micBtnP2.classList.toggle('active', this.currentPlayer === 2);
            });
        }
    }

    updateProgress(currentTime, duration) {
        if (duration > 0) {
            const percent = (currentTime / duration) * 100;
            this.el.progressBar.style.width = percent + '%';
        }
    }

    updateGame(currentTime) {
        const newActiveIndex = this.lyricsParser.getActiveLineIndex(currentTime);

        if (newActiveIndex !== this.activeLineIndex) {
            this.activeLineIndex = newActiveIndex;
            this.updateCurrentPlayer();
            this.renderLyrics(currentTime);
        }

        // Scoring pour le joueur actif
        if (this.activeLineIndex >= 0) {
            const player = this.lineAssignments[this.activeLineIndex];
            const volume = this.audio.getVolume();
            const pitch = this.audio.detectPitch();
            const isSinging = volume > 0.02 && pitch > 50;

            // Ne scorer que le joueur actif
            if (player === this.currentPlayer && isSinging) {
                const points = Math.min(volume * 10, 1) * 100 * 0.016;
                this.scores['p' + player] += points;
                this.maxScores['p' + player] += 100 * 0.016;

                // Historique par ligne
                if (!this.lineScores['p' + player][this.activeLineIndex]) {
                    this.lineScores['p' + player][this.activeLineIndex] = 0;
                }
                this.lineScores['p' + player][this.activeLineIndex] += points;
            } else {
                this.maxScores['p' + player] += 100 * 0.016;
            }

            this.updateScoreDisplay();
        }
    }

    updateCurrentPlayer() {
        if (this.activeLineIndex < 0) return;
        this.currentPlayer = this.lineAssignments[this.activeLineIndex];
        this.updateTurnIndicator();

        // Mettre à jour les indicateurs visuels
        this.el.panelP1.classList.toggle('active', this.currentPlayer === 1);
        this.el.panelP2.classList.toggle('active', this.currentPlayer === 2);

        this.el.indicatorP1.textContent = this.currentPlayer === 1 ? 'À toi de chanter !' : 'En attente';
        this.el.indicatorP2.textContent = this.currentPlayer === 2 ? 'À toi de chanter !' : 'En attente';

        // Mettre à jour les boutons micro
        this.el.micBtnP1.classList.toggle('active', this.currentPlayer === 1 && this.playerMicActive.p1);
        this.el.micBtnP2.classList.toggle('active', this.currentPlayer === 2 && this.playerMicActive.p2);
    }

    updateTurnIndicator() {
        this.el.turnIndicator.textContent = `Tour de J${this.currentPlayer}`;
        this.el.turnIndicator.className = 'turn-indicator p' + this.currentPlayer;
    }

    updateScoreDisplay() {
        this.el.scoreP1.textContent = Math.round(this.scores.p1);
        this.el.scoreP2.textContent = Math.round(this.scores.p2);
    }

    renderLyrics(currentTime) {
        const lines = this.lyricsParser.getLines();
        if (lines.length === 0) return;

        const activeIndex = this.activeLineIndex;
        const currentPlayer = activeIndex >= 0 ? this.lineAssignments[activeIndex] : 1;
        const playerColor = currentPlayer === 1 ? '#e94560' : '#00d9ff';

        const html = [];

        if (activeIndex >= 0) {
            html.push(`<p class="lyric-line active" style="color:${playerColor}">${this.escapeHtml(lines[activeIndex].text)}</p>`);
        } else {
            html.push(`<p class="lyric-line active">♪ Préparez-vous ♪</p>`);
        }

        const upcoming = this.lyricsParser.getUpcomingLines(currentTime, 1);
        for (const line of upcoming) {
            html.push(`<p class="lyric-line upcoming">${this.escapeHtml(line.text)}</p>`);
        }

        this.el.lyricsDisplay.innerHTML = html.join('');
    }

    animate() {
        if (!this.isPlaying) return;

        this.drawVisualizer(this.el.vizP1, this.vizCtxP1, '#e94560');
        this.drawVisualizer(this.el.vizP2, this.vizCtxP2, '#00d9ff');

        this.animationId = requestAnimationFrame(() => this.animate());
    }

    drawVisualizer(canvas, ctx, color) {
        const width = canvas.width;
        const height = canvas.height;

        ctx.fillStyle = '#12121a';
        ctx.fillRect(0, 0, width, height);

        const data = this.audio.getFrequencyData();
        const barWidth = (width / data.length) * 4;
        let x = 0;

        for (let i = 0; i < data.length; i += 2) {
            const barHeight = (data[i] / 255) * height;
            ctx.fillStyle = color;
            ctx.globalAlpha = 0.3 + (data[i] / 255) * 0.7;
            ctx.fillRect(x, height - barHeight, barWidth - 1, barHeight);
            x += barWidth;
        }
        ctx.globalAlpha = 1;
    }

    getResults() {
        const p1Pct = this.maxScores.p1 > 0 ? Math.round((this.scores.p1 / this.maxScores.p1) * 100) : 0;
        const p2Pct = this.maxScores.p2 > 0 ? Math.round((this.scores.p2 / this.maxScores.p2) * 100) : 0;

        let winner;
        if (this.scores.p1 > this.scores.p2) winner = 1;
        else if (this.scores.p2 > this.scores.p1) winner = 2;
        else winner = 0; // Égalité

        return {
            player1: { score: Math.round(this.scores.p1), percentage: p1Pct },
            player2: { score: Math.round(this.scores.p2), percentage: p2Pct },
            winner
        };
    }

    endGame() {
        this.isPlaying = false;
        if (this.animationId) {
            cancelAnimationFrame(this.animationId);
        }
        this.audio.stopMic();
        this.audio.stopMusic();
        const results = this.getResults();
        if (this.onEnd) this.onEnd(results);
        return results;
    }

    quit() {
        this.isPlaying = false;
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
window.DuelMode = DuelMode;
