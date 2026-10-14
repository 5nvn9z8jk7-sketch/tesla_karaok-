/**
 * Tesla Karaoké Party - Application principale
 * Gère la navigation, l'état global, les réglages et l'initialisation des modes de jeu
 */

class TeslaKaraokeApp {
    constructor() {
        // Moteurs et systèmes
        this.audio = new AudioEngine();
        this.scoring = new ScoringSystem(this.audio);

        // Modes de jeu (initialisés après chargement des chansons)
        this.soloMode = null;
        this.duelMode = null;
        this.blindTestMode = null;
        this.freestyleMode = null;

        // État
        this.currentScreen = 'menu';
        this.currentMode = null;
        this.selectedSong = null;
        this.songs = [];
        this.settings = this.loadSettings();

        // Éléments DOM
        this.screens = document.querySelectorAll('.screen');
        this.overlays = {
            micPermission: document.getElementById('overlay-mic-permission'),
            loading: document.getElementById('overlay-loading')
        };

        this.init();
    }

    async init() {
        this.applySettings();
        this.bindNavigation();
        await this.loadSongs();
        this.initGameModes();
        this.showScreen('menu');
        this.hideOverlay('loading');
    }

    /**
     * Charge la liste des chansons depuis le manifest
     */
    async loadSongs() {
        this.showOverlay('loading');
        try {
            const response = await fetch('songs/manifest.json');
            this.songs = await response.json();
        } catch (err) {
            console.warn('Manifest non trouvé, utilisation des chansons par défaut');
            // Chansons par défaut si pas de manifest
            this.songs = [
                {
                    id: 'demo-1',
                    title: 'Joyeux Anniversaire',
                    artist: 'Traditionnel',
                    difficulty: 'easy',
                    audioUrl: 'songs/demo/audio.mp3',
                    lyricsUrl: 'songs/demo/lyrics.lrc'
                },
                {
                    id: 'demo-2',
                    title: 'Twinkle Twinkle',
                    artist: 'Traditionnel',
                    difficulty: 'easy',
                    audioUrl: 'songs/demo/audio.mp3',
                    lyricsUrl: 'songs/demo/lyrics.lrc'
                },
                {
                    id: 'demo-3',
                    title: 'Happy Birthday (EN)',
                    artist: 'Traditionnel',
                    difficulty: 'easy',
                    audioUrl: 'songs/demo/audio.mp3',
                    lyricsUrl: 'songs/demo/lyrics.lrc'
                }
            ];
        }
        this.hideOverlay('loading');
    }

    /**
     * Initialise les modes de jeu
     */
    initGameModes() {
        this.soloMode = new SoloMode(this.audio, this.scoring);
        this.duelMode = new DuelMode(this.audio);
        this.blindTestMode = new BlindTestMode(this.audio, this.songs);
        this.freestyleMode = new FreestyleMode(this.audio);

        // Callbacks de fin de partie
        this.soloMode.onEnd = (results) => this.showResults(results);
        this.duelMode.onEnd = (results) => this.showResults(results);
        this.blindTestMode.onEnd = (results) => this.showResults(results);
    }

    /**
     * Navigation entre les écrans
     */
    bindNavigation() {
        // Boutons de mode du menu
        document.querySelectorAll('.btn-mode').forEach(btn => {
            btn.addEventListener('click', () => {
                const mode = btn.dataset.mode;
                this.selectMode(mode);
            });
        });

        // Boutons retour
        document.querySelectorAll('[data-back]').forEach(btn => {
            btn.addEventListener('click', () => {
                const back = btn.dataset.back;
                this.handleBack(back);
            });
        });

        // Réglages
        document.getElementById('btn-settings').addEventListener('click', () => {
            this.showScreen('settings');
        });

        document.getElementById('btn-about').addEventListener('click', () => {
            this.showScreen('about');
        });

        // Bindings des réglages
        document.getElementById('setting-volume-music').addEventListener('input', (e) => {
            this.settings.volumeMusic = e.target.value / 100;
            this.audio.setMusicVolume(this.settings.volumeMusic);
            this.saveSettings();
        });

        document.getElementById('setting-volume-mic').addEventListener('input', (e) => {
            this.settings.volumeMic = e.target.value / 100;
            this.audio.setMicVolume(this.settings.volumeMic);
            this.saveSettings();
        });

        document.getElementById('setting-lyrics-size').addEventListener('change', (e) => {
            this.settings.lyricsSize = e.target.value;
            this.applyLyricsSize();
            this.saveSettings();
        });

        document.getElementById('setting-theme').addEventListener('change', (e) => {
            this.settings.theme = e.target.value;
            this.applyTheme();
            this.saveSettings();
        });

        // Retry micro permission
        document.getElementById('btn-mic-retry').addEventListener('click', () => {
            this.hideOverlay('micPermission');
        });
    }

    /**
     * Sélectionne un mode de jeu
     */
    selectMode(mode) {
        this.currentMode = mode;

        switch (mode) {
            case 'solo':
            case 'duel':
                this.showSongSelect(mode);
                break;
            case 'blindtest':
                this.startBlindTest();
                break;
            case 'freestyle':
                this.startFreestyle();
                break;
        }
    }

    /**
     * Affiche la sélection de chanson
     */
    showSongSelect(mode) {
        const title = mode === 'solo' ? 'Choisis ta chanson' : 'Choisis la chanson du duel';
        document.getElementById('select-title').textContent = title;

        const searchInput = document.getElementById('song-search');
        searchInput.value = '';

        this.renderSongList(mode, '');

        searchInput.oninput = (e) => {
            this.renderSongList(mode, e.target.value);
        };

        this.showScreen('song-select');
        if (window.matchMedia && window.matchMedia('(min-width: 1024px)').matches) {
            searchInput.focus();
        }
    }

    /**
     * Affiche la liste des chansons filtrée
     */
    renderSongList(mode, query) {
        const list = document.getElementById('song-list');
        list.innerHTML = '';

        const q = (query || '').trim().toLowerCase();
        const filtered = q ? this.songs.filter(song =>
            song.title.toLowerCase().includes(q) ||
            (song.artist || '').toLowerCase().includes(q)
        ) : this.songs;

        if (filtered.length === 0) {
            list.innerHTML = '<p class="song-list-empty">Aucune chanson trouvée</p>';
            return;
        }

        for (const song of filtered) {
            const card = document.createElement('div');
            card.className = 'song-card';
            card.innerHTML = `
                <div class="song-name">${this.escapeHtml(song.title)}</div>
                <div class="song-artist">${this.escapeHtml(song.artist)}</div>
                <div class="song-meta">
                    <span class="difficulty ${song.difficulty}">${song.difficulty}</span>
                    ${song.duration ? `<span>⏱️ ${song.duration}</span>` : ''}
                </div>
            `;
            card.addEventListener('click', () => {
                this.selectedSong = song;
                this.startGame(mode);
            });
            list.appendChild(card);
        }
    }

    /**
     * Démarre une partie
     */
    async startGame(mode) {
        this.showOverlay('loading');

        try {
            switch (mode) {
                case 'solo':
                    await this.soloMode.start(this.selectedSong);
                    this.showScreen('solo');
                    break;
                case 'duel':
                    await this.duelMode.start(this.selectedSong);
                    this.showScreen('duel');
                    break;
            }
        } catch (err) {
            console.error('Erreur démarrage jeu:', err);
            alert('Erreur: impossible de charger la chanson. Vérifie que les fichiers audio existent.');
        }

        this.hideOverlay('loading');
    }

    /**
     * Démarre le blind test
     */
    async startBlindTest() {
        this.showOverlay('loading');
        this.showScreen('blindtest');
        await this.blindTestMode.start();
        this.hideOverlay('loading');
    }

    /**
     * Démarre le freestyle
     */
    startFreestyle() {
        this.showScreen('freestyle');
        this.freestyleMode.start();
    }

    /**
     * Affiche les résultats
     */
    showResults(results) {
        const title = document.getElementById('results-title');
        const content = document.getElementById('results-content');
        const stars = document.getElementById('results-stars');

        if (results.winner !== undefined) {
            // Résultats duel
            title.textContent = results.winner === 0 ? 'Égalité !' :
                (results.winner === 1 ? 'Joueur 1 gagne !' : 'Joueur 2 gagne !');
            content.innerHTML = `
                <p>J1 (Rouge) : ${results.player1.score} points (${results.player1.percentage}%)</p>
                <p>J2 (Bleu) : ${results.player2.score} points (${results.player2.percentage}%)</p>
            `;
            stars.textContent = results.winner === 0 ? '🤝' : (results.winner === 1 ? '🔴🏆' : '🔵🏆');
        } else if (results.rank) {
            // Résultats solo
            title.textContent = `${results.emoji} ${results.title}`;
            content.innerHTML = `
                <p>Score final : <strong>${results.score}</strong></p>
                <p>Précision : <strong>${results.percentage}%</strong></p>
                <p>Meilleur combo : <strong>${results.bestStreak}</strong></p>
                <p>Rang : <strong>${results.rank}</strong></p>
            `;
            stars.textContent = '⭐'.repeat(results.stars) + '☆'.repeat(5 - results.stars);
        } else if (results.total !== undefined) {
            // Résultats blind test
            title.textContent = `${results.emoji} ${results.title}`;
            content.innerHTML = `
                <p>Score : <strong>${results.score} / ${results.total}</strong></p>
                <p>Taux de réussite : <strong>${results.percentage}%</strong></p>
            `;
            stars.textContent = '⭐'.repeat(Math.round(results.percentage / 20));
        }

        this.showScreen('results');
    }

    /**
     * Gère le bouton retour
     */
    handleBack(target) {
        // Arrêter le mode en cours
        this.stopCurrentMode();

        if (target === 'menu') {
            this.showScreen('menu');
        }
    }

    /**
     * Arrête le mode de jeu en cours
     */
    stopCurrentMode() {
        let results = null;

        switch (this.currentMode) {
            case 'solo':
                results = this.soloMode.quit();
                break;
            case 'duel':
                results = this.duelMode.quit();
                break;
            case 'blindtest':
                results = this.blindTestMode.quit();
                break;
            case 'freestyle':
                results = this.freestyleMode.quit();
                break;
        }

        this.currentMode = null;

        // Si on a des résultats (fin naturelle), les afficher
        if (results && this.currentScreen !== 'menu') {
            // Vérifier si c'est une fin de partie (pas un quit)
            const screenId = this.currentScreen;
            if (screenId === 'solo' || screenId === 'duel') {
                // C'était une fin naturelle
                setTimeout(() => this.showResults(results), 100);
            }
        }
    }

    /**
     * Affiche un écran et masque les autres
     */
    showScreen(screenId) {
        this.screens.forEach(screen => {
            screen.classList.toggle('active', screen.id === 'screen-' + screenId);
        });
        this.currentScreen = screenId;
    }

    /**
     * Affiche un overlay
     */
    showOverlay(name) {
        if (this.overlays[name]) {
            this.overlays[name].classList.remove('hidden');
        }
    }

    /**
     * Masque un overlay
     */
    hideOverlay(name) {
        if (this.overlays[name]) {
            this.overlays[name].classList.add('hidden');
        }
    }

    /**
     * Applique les réglages
     */
    applySettings() {
        this.applyTheme();
        this.applyLyricsSize();
        this.audio.setMusicVolume(this.settings.volumeMusic || 0.8);
        this.audio.setMicVolume(this.settings.volumeMic || 0.6);

        // Remplir les contrôles de réglages
        const volMusic = document.getElementById('setting-volume-music');
        const volMic = document.getElementById('setting-volume-mic');
        const lyricsSize = document.getElementById('setting-lyrics-size');
        const theme = document.getElementById('setting-theme');

        if (volMusic) volMusic.value = (this.settings.volumeMusic || 0.8) * 100;
        if (volMic) volMic.value = (this.settings.volumeMic || 0.6) * 100;
        if (lyricsSize) lyricsSize.value = this.settings.lyricsSize || 'normal';
        if (theme) theme.value = this.settings.theme || 'dark';
    }

    applyTheme() {
        document.body.className = '';
        if (this.settings.theme && this.settings.theme !== 'dark') {
            document.body.classList.add('theme-' + this.settings.theme);
        }
    }

    applyLyricsSize() {
        document.body.classList.remove('lyrics-normal', 'lyrics-large', 'lyrics-xlarge');
        document.body.classList.add('lyrics-' + (this.settings.lyricsSize || 'normal'));
    }

    /**
     * Sauvegarde les réglages dans localStorage
     */
    saveSettings() {
        localStorage.setItem('tesla-karaoke-settings', JSON.stringify(this.settings));
    }

    /**
     * Charge les réglages depuis localStorage
     */
    loadSettings() {
        try {
            const saved = localStorage.getItem('tesla-karaoke-settings');
            return saved ? JSON.parse(saved) : {};
        } catch {
            return {};
        }
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text || '';
        return div.innerHTML;
    }
}

// Démarrage de l'application
document.addEventListener('DOMContentLoaded', () => {
    window.app = new TeslaKaraokeApp();
});
