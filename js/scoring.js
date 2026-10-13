/**
 * Tesla Karaoké Party - Système de Scoring
 * Analyse la voix du joueur et attribue un score basé sur:
 * - Présence vocale (le joueur chante-t-il ?)
 * - Timing (chante-t-il au bon moment ?)
 * - Régularité du pitch
 */

class ScoringSystem {
    constructor(audioEngine) {
        this.audioEngine = audioEngine;
        this.score = 0;
        this.maxScore = 0;
        this.streak = 0;
        this.bestStreak = 0;
        this.lineScores = []; // Score par ligne
        this.isActive = false;
        this.volumeThreshold = 0.02; // Seuil minimum de volume pour détecter du chant
        this.pitchStabilityThreshold = 0.15; // Variation max du pitch pour "stable"
        this.previousPitch = 0;
        this.pitchHistory = [];
        this.combo = 0;
        this.onScoreUpdate = null;
        this.onFeedback = null;
    }

    start() {
        this.score = 0;
        this.maxScore = 0;
        this.streak = 0;
        this.bestStreak = 0;
        this.lineScores = [];
        this.pitchHistory = [];
        this.combo = 0;
        this.isActive = true;
    }

    stop() {
        this.isActive = false;
    }

    /**
     * Met à jour le score en fonction de l'état actuel
     * Appelé à chaque frame (~60fps)
     */
    update(currentTime, activeLine, lineProgress) {
        if (!this.isActive) return;

        const volume = this.audioEngine.getVolume();
        const pitch = this.audioEngine.detectPitch();
        const isSinging = volume > this.volumeThreshold && pitch > 50; // > 50Hz = voix humaine

        // Mettre à jour l'historique du pitch
        if (isSinging) {
            this.pitchHistory.push(pitch);
            if (this.pitchHistory.length > 30) this.pitchHistory.shift();
        }

        if (!activeLine) return;

        // Calculer le score de présence
        let presenceScore = 0;
        if (isSinging) {
            presenceScore = Math.min(volume * 10, 1); // Normaliser
        }

        // Calculer la stabilité du pitch
        let pitchScore = 0;
        if (this.pitchHistory.length >= 5) {
            const avgPitch = this.pitchHistory.reduce((a, b) => a + b, 0) / this.pitchHistory.length;
            const variance = this.pitchHistory.reduce((sum, p) => sum + Math.pow(p - avgPitch, 2), 0) / this.pitchHistory.length;
            const stability = 1 - Math.min(Math.sqrt(variance) / avgPitch, 1);
            pitchScore = stability;
        }

        // Score combiné pour cette frame
        const frameScore = (presenceScore * 0.6 + pitchScore * 0.4);

        // Pondération par la progression dans la ligne
        const lineWeight = lineProgress;

        // Ajouter au score total
        const points = frameScore * 100 * 0.016; // ~1.6 points par frame à 60fps si parfait
        this.score += points;
        this.maxScore += 100 * 0.016;

        // Système de streak
        if (frameScore > 0.5) {
            this.streak++;
            this.combo++;
            if (this.streak > this.bestStreak) this.bestStreak = this.streak;
        } else {
            if (this.streak > 0) {
                // Bonus de fin de streak
                this.score += this.streak * 10;
            }
            this.streak = 0;
            this.combo = 0;
        }

        // Feedback visuel
        this.giveFeedback(frameScore, isSinging);

        // Notifier
        if (this.onScoreUpdate) {
            this.onScoreUpdate(this.getScore(), this.getPercentage(), this.combo);
        }
    }

    /**
     * Finalise le score d'une ligne
     */
    finishLine(lineIndex, lineText) {
        const lineScore = this.lineScores[lineIndex] || 0;
        return {
            index: lineIndex,
            text: lineText,
            score: Math.round(lineScore),
            stars: this.getStarsForScore(lineScore)
        };
    }

    /**
     * Donne un feedback textuel basé sur la performance
     */
    giveFeedback(frameScore, isSinging) {
        if (!this.onFeedback) return;

        let feedback = '';
        let type = '';

        if (!isSinging) {
            feedback = 'Chante !';
            type = 'bad';
        } else if (frameScore > 0.8) {
            const messages = ['🔥 Incroyable !', '⭐ Parfait !', '🎤 Super !', '💪 Génial !', '🌟 Excellent !'];
            feedback = messages[Math.floor(Math.random() * messages.length)];
            type = 'good';
        } else if (frameScore > 0.5) {
            feedback = '👍 Bien !';
            type = 'good';
        } else if (frameScore > 0.3) {
            feedback = 'Continue...';
            type = '';
        } else {
            feedback = 'Plus fort !';
            type = 'bad';
        }

        // Bonus de combo
        if (this.combo > 5) {
            feedback += ` x${this.combo} COMBO!`;
        }

        this.onFeedback(feedback, type);
    }

    /**
     * Retourne le score actuel
     */
    getScore() {
        return Math.round(this.score);
    }

    /**
     * Retourne le pourcentage de réussite
     */
    getPercentage() {
        if (this.maxScore === 0) return 0;
        return Math.round((this.score / this.maxScore) * 100);
    }

    /**
     * Attribue des étoiles selon le pourcentage
     */
    getStars() {
        return this.getStarsForScore(this.getPercentage());
    }

    getStarsForScore(percentage) {
        if (percentage >= 90) return 5;
        if (percentage >= 75) return 4;
        if (percentage >= 60) return 3;
        if (percentage >= 40) return 2;
        if (percentage >= 20) return 1;
        return 0;
    }

    /**
     * Retourne un rang basé sur le pourcentage
     */
    getRank() {
        const pct = this.getPercentage();
        if (pct >= 95) return { rank: 'S', title: 'Légende du Karaoké', emoji: '👑' };
        if (pct >= 85) return { rank: 'A', title: 'Star montante', emoji: '🌟' };
        if (pct >= 70) return { rank: 'B', title: 'Bon chanteur', emoji: '🎤' };
        if (pct >= 55) return { rank: 'C', title: 'En progrès', emoji: '🎵' };
        if (pct >= 40) return { rank: 'D', title: 'Débutant', emoji: '🎶' };
        return { rank: 'F', title: 'À retravailler', emoji: '😅' };
    }

    /**
     * Retourne un résumé complet des résultats
     */
    getResults() {
        const rankInfo = this.getRank();
        return {
            score: this.getScore(),
            percentage: this.getPercentage(),
            stars: this.getStars(),
            rank: rankInfo.rank,
            title: rankInfo.title,
            emoji: rankInfo.emoji,
            bestStreak: this.bestStreak,
            linesSung: this.lineScores.filter(s => s > 0).length
        };
    }

    /**
     * Réinitialise le système
     */
    reset() {
        this.score = 0;
        this.maxScore = 0;
        this.streak = 0;
        this.bestStreak = 0;
        this.lineScores = [];
        this.pitchHistory = [];
        this.combo = 0;
    }
}

// Instance globale
window.ScoringSystem = ScoringSystem;
