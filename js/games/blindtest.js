/**
 * Tesla Karaoké Party - Mode Blind Test
 * Devine le titre de la chanson à partir d'un extrait
 */

class BlindTestMode {
    constructor(audioEngine, songs) {
        this.audio = audioEngine;
        this.allSongs = songs;
        this.rounds = 5;
        this.currentRound = 0;
        this.score = 0;
        this.isPlaying = false;
        this.currentSong = null;
        this.choices = [];
        this.extractDuration = 10; // secondes d'extrait
        this.answered = false;
        this.roundTimer = null;
        this.nextRoundTimer = null;
        this.onEnd = null;

        // Éléments DOM
        this.el = {
            screen: document.getElementById('screen-blindtest'),
            round: document.getElementById('blind-round'),
            equalizer: document.getElementById('blind-equalizer'),
            choices: document.getElementById('blind-choices'),
            feedback: document.getElementById('blind-feedback'),
            score: document.getElementById('blind-score')
        };
    }

    async start() {
        this.currentRound = 0;
        this.score = 0;
        this.updateDisplay();
        await this.nextRound();
    }

    async nextRound() {
        this.currentRound++;
        this.answered = false;

        if (this.currentRound > this.rounds) {
            this.endGame();
            const results = this.getResults();
            if (this.onEnd) this.onEnd(results);
            return;
        }

        this.updateDisplay();
        this.el.feedback.textContent = '';
        this.el.feedback.className = 'feedback';

        // Choisir une chanson au hasard
        const availableSongs = this.allSongs.filter(s => s.audioUrl);
        if (availableSongs.length === 0) {
            this.el.feedback.textContent = 'Aucune chanson disponible. Ajoute des morceaux dans songs/.';
            return;
        }

        this.currentSong = availableSongs[Math.floor(Math.random() * availableSongs.length)];

        // Générer les choix (1 bonne + 3 mauvaises)
        this.choices = this.generateChoices(this.currentSong, availableSongs);
        this.renderChoices();

        // Charger et jouer l'extrait
        try {
            await this.audio.loadMusic(this.currentSong.audioUrl, this.currentSong.fallbackAudioUrl);

            // Démarrer à un point aléatoire de la chanson (pas le début)
            const duration = this.audio.getDuration();
            const startTime = Math.random() * (duration - this.extractDuration - 5) + 5;
            this.audio.seekMusic(startTime);

            this.audio.playMusic();
            this.isPlaying = true;

            // Arrêter après extractDuration secondes
            this.roundTimer = setTimeout(() => {
                if (this.isPlaying && !this.answered) {
                    this.audio.pauseMusic();
                    this.showFeedback(false, 'Trop lent ! La réponse était : ' + this.currentSong.title);
                    this.nextRoundTimer = setTimeout(() => this.nextRound(), 3000);
                }
            }, this.extractDuration * 1000);

        } catch (err) {
            console.error('Erreur chargement extrait:', err);
            this.el.feedback.textContent = 'Erreur de chargement';
        }
    }

    generateChoices(correctSong, allSongs) {
        const choices = [correctSong];

        // Ajouter 3 mauvaises réponses
        const wrongSongs = allSongs.filter(s => s.id !== correctSong.id);
        const shuffled = wrongSongs.sort(() => 0.5 - Math.random());

        for (let i = 0; i < Math.min(3, shuffled.length); i++) {
            choices.push(shuffled[i]);
        }

        // Mélanger
        return choices.sort(() => 0.5 - Math.random());
    }

    renderChoices() {
        this.el.choices.innerHTML = '';

        for (const song of this.choices) {
            const btn = document.createElement('button');
            btn.className = 'blind-choice';
            btn.dataset.songId = song.id;
            btn.textContent = `${song.title} - ${song.artist}`;
            btn.addEventListener('click', () => this.answer(song));
            this.el.choices.appendChild(btn);
        }
    }

    answer(selectedSong) {
        if (this.answered) return;
        this.answered = true;
        this.isPlaying = false;
        this.audio.pauseMusic();

        const isCorrect = selectedSong.id === this.currentSong.id;

        // Colorer les boutons
        const buttons = this.el.choices.querySelectorAll('.blind-choice');
        buttons.forEach(btn => {
            btn.disabled = true;
            if (btn.dataset.songId === this.currentSong.id) {
                btn.classList.add('correct');
            } else if (btn.dataset.songId === selectedSong.id && !isCorrect) {
                btn.classList.add('wrong');
            }
        });

        if (isCorrect) {
            this.score++;
            this.showFeedback(true, '✅ Correct ! +100 points');
        } else {
            this.showFeedback(false, `❌ Faux ! C'était : ${this.currentSong.title}`);
        }

        this.updateDisplay();

        this.nextRoundTimer = setTimeout(() => this.nextRound(), 2500);
    }

    showFeedback(success, message) {
        this.el.feedback.textContent = message;
        this.el.feedback.className = 'feedback ' + (success ? 'good' : 'bad');
    }

    updateDisplay() {
        this.el.round.textContent = `Manche ${this.currentRound}/${this.rounds}`;
        this.el.score.textContent = `Score: ${this.score} / ${this.rounds}`;
    }

    getResults() {
        const percentage = Math.round((this.score / this.rounds) * 100);
        let title, emoji;

        if (percentage === 100) { title = 'Oreille absolue !'; emoji = '🎵👑'; }
        else if (percentage >= 80) { title = 'Excellent ear'; emoji = '🎵🌟'; }
        else if (percentage >= 60) { title = 'Bon musicien'; emoji = '🎵🎤'; }
        else if (percentage >= 40) { title = 'Pas mal'; emoji = '🎵'; }
        else { title = 'À écouter plus souvent'; emoji = '🎧'; }

        return {
            score: this.score,
            total: this.rounds,
            percentage,
            title,
            emoji
        };
    }

    clearTimers() {
        if (this.roundTimer) {
            clearTimeout(this.roundTimer);
            this.roundTimer = null;
        }
        if (this.nextRoundTimer) {
            clearTimeout(this.nextRoundTimer);
            this.nextRoundTimer = null;
        }
    }

    endGame() {
        this.isPlaying = false;
        this.clearTimers();
        this.audio.stopMusic();
    }

    quit() {
        this.isPlaying = false;
        this.clearTimers();
        this.audio.stopMusic();
        return null;
    }
}

// Instance globale
window.BlindTestMode = BlindTestMode;
