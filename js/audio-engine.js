/**
 * Tesla Karaoké Party - Moteur Audio
 * Gestion de la lecture, des effets vocaux, du micro et de la visualisation
 * Utilise Web Audio API pour tout le traitement audio
 */

class AudioEngine {
    constructor() {
        this.audioContext = null;
        this.musicSource = null;
        this.musicGain = null;
        this.micStream = null;
        this.micSource = null;
        this.micGain = null;
        this.analyser = null;
        this.effectsChain = [];
        this.currentEffect = 'none';
        this.isPlaying = false;
        this.isMicActive = false;
        this.volumeMusic = 0.8;
        this.volumeMic = 0.6;
        this.onTimeUpdate = null;
        this.onEnded = null;
        this.audioElement = null;
        this.recordedChunks = [];
        this.mediaRecorder = null;
        this.beatOscillators = [];
        this.beatInterval = null;
        this.currentBeat = 'hiphop';
    }

    /**
     * Initialise le contexte audio (doit être appelé après une interaction utilisateur)
     */
    async init() {
        if (this.audioContext) return;
        this.audioContext = new (window.AudioContext || window.webkitAudioContext)();

        // Nœuds principaux
        this.musicGain = this.audioContext.createGain();
        this.musicGain.gain.value = this.volumeMusic;
        this.musicGain.connect(this.audioContext.destination);

        // Analyseur pour la visualisation
        this.analyser = this.audioContext.createAnalyser();
        this.analyser.fftSize = 256;
        this.analyser.connect(this.audioContext.destination);

        return this.audioContext;
    }

    /**
     * Charge et joue un fichier audio (instrumental)
     * Essaie d'abord l'URL principale, puis le fallback si échec
     */
    async loadMusic(url, fallbackUrl) {
        await this.init();
        this.stopMusic();

        // Essayer l'URL principale, puis le fallback
        const urls = fallbackUrl ? [url, fallbackUrl] : [url];

        for (const tryUrl of urls) {
            try {
                await this.tryLoadMusic(tryUrl);
                return; // Succès
            } catch (err) {
                console.warn(`Échec chargement ${tryUrl}, essai suivant...`);
                continue;
            }
        }

        throw new Error(`Impossible de charger l'audio: ${urls.join(', ')}`);
    }

    /**
     * Essaie de charger une URL audio spécifique
     */
    tryLoadMusic(url) {
        return new Promise((resolve, reject) => {
            this.audioElement = new Audio(url);
            this.audioElement.crossOrigin = 'anonymous';

            // Connecter l'élément audio au graphe Web Audio
            this.musicSource = this.audioContext.createMediaElementSource(this.audioElement);
            this.musicSource.connect(this.musicGain);
            this.musicSource.connect(this.analyser);

            this.audioElement.addEventListener('timeupdate', () => {
                if (this.onTimeUpdate) {
                    this.onTimeUpdate(this.audioElement.currentTime, this.audioElement.duration);
                }
            });

            this.audioElement.addEventListener('ended', () => {
                this.isPlaying = false;
                if (this.onEnded) this.onEnded();
            });

            this.audioElement.addEventListener('canplaythrough', () => resolve());
            this.audioElement.addEventListener('error', (e) => reject(e));

            this.audioElement.load();
        });
    }

    playMusic() {
        if (this.audioElement) {
            this.audioElement.play();
            this.isPlaying = true;
        }
    }

    pauseMusic() {
        if (this.audioElement) {
            this.audioElement.pause();
            this.isPlaying = false;
        }
    }

    stopMusic() {
        if (this.audioElement) {
            this.audioElement.pause();
            this.audioElement.currentTime = 0;
            this.isPlaying = false;
        }
        if (this.musicSource) {
            this.musicSource.disconnect();
            this.musicSource = null;
        }
    }

    seekMusic(time) {
        if (this.audioElement) {
            this.audioElement.currentTime = time;
        }
    }

    getCurrentTime() {
        return this.audioElement ? this.audioElement.currentTime : 0;
    }

    getDuration() {
        return this.audioElement ? this.audioElement.duration : 0;
    }

    setMusicVolume(value) {
        this.volumeMusic = value;
        if (this.musicGain) {
            this.musicGain.gain.setTargetAtTime(value, this.audioContext.currentTime, 0.05);
        }
    }

    /**
     * Active/désactive le micro avec effets
     */
    async toggleMic(active) {
        if (active) {
            await this.startMic();
        } else {
            this.stopMic();
        }
        this.isMicActive = active;
        return active;
    }

    async startMic() {
        await this.init();
        try {
            this.micStream = await navigator.mediaDevices.getUserMedia({
                audio: {
                    echoCancellation: false,
                    noiseSuppression: false,
                    autoGainControl: false
                }
            });

            this.micSource = this.audioContext.createMediaStreamSource(this.micStream);
            this.micGain = this.audioContext.createGain();
            this.micGain.gain.value = this.volumeMic;

            // Chaîne d'effets
            this.buildEffectsChain();

            if (this.effectsChain.length > 0) {
                this.micSource.connect(this.effectsChain[0]);
                this.effectsChain[this.effectsChain.length - 1].connect(this.micGain);
            } else {
                this.micSource.connect(this.micGain);
            }
            this.micGain.connect(this.audioContext.destination);
            this.micGain.connect(this.analyser);

            // MediaRecorder pour l'enregistrement
            this.mediaRecorder = new MediaRecorder(this.micStream);
            this.mediaRecorder.ondataavailable = (e) => {
                if (e.data.size > 0) this.recordedChunks.push(e.data);
            };

        } catch (err) {
            console.error('Erreur micro:', err);
            throw err;
        }
    }

    stopMic() {
        if (this.micStream) {
            this.micStream.getTracks().forEach(track => track.stop());
            this.micStream = null;
        }
        if (this.micSource) {
            this.micSource.disconnect();
            this.micSource = null;
        }
        this.effectsChain.forEach(node => node.disconnect());
        this.effectsChain = [];
        if (this.mediaRecorder && this.mediaRecorder.state !== 'inactive') {
            this.mediaRecorder.stop();
        }
    }

    /**
     * Construit la chaîne d'effets vocaux
     */
    buildEffectsChain() {
        // Nettoyer l'ancienne chaîne
        this.effectsChain.forEach(node => node.disconnect());
        this.effectsChain = [];

        const ctx = this.audioContext;

        switch (this.currentEffect) {
            case 'echo': {
                const delay = ctx.createDelay(1.0);
                delay.delayTime.value = 0.25;
                const feedback = ctx.createGain();
                feedback.gain.value = 0.4;
                const wet = ctx.createGain();
                wet.gain.value = 0.5;

                delay.connect(feedback);
                feedback.connect(delay);
                delay.connect(wet);
                this.effectsChain.push(delay, wet);
                break;
            }
            case 'robot': {
                // Vocoder-like effect avec ring modulator
                const ringMod = ctx.createGain();
                ringMod.gain.value = 0;
                const oscillator = ctx.createOscillator();
                oscillator.frequency.value = 30;
                oscillator.type = 'sine';
                const lfoGain = ctx.createGain();
                lfoGain.gain.value = 1;
                oscillator.connect(lfoGain);
                lfoGain.connect(ringMod.gain);
                oscillator.start();

                const filter = ctx.createBiquadFilter();
                filter.type = 'bandpass';
                filter.frequency.value = 800;
                filter.Q.value = 5;

                ringMod.connect(filter);
                this.effectsChain.push(ringMod, filter);
                break;
            }
            case 'distortion': {
                const waveshaper = ctx.createWaveShaper();
                waveshaper.curve = this.makeDistortionCurve(50);
                waveshaper.oversample = '4x';
                this.effectsChain.push(waveshaper);
                break;
            }
            default:
                // Pas d'effet, connexion directe
                break;
        }
    }

    makeDistortionCurve(amount) {
        const samples = 44100;
        const curve = new Float32Array(samples);
        const deg = Math.PI / 180;
        for (let i = 0; i < samples; i++) {
            const x = (i * 2) / samples - 1;
            curve[i] = (3 + amount) * x * 20 * deg / (Math.PI + amount * Math.abs(x));
        }
        return curve;
    }

    /**
     * Change l'effet vocal en temps réel
     */
    setEffect(effectName) {
        this.currentEffect = effectName;
        if (this.isMicActive && this.micSource) {
            // Reconnecter avec le nouvel effet
            this.micSource.disconnect();
            this.effectsChain.forEach(node => node.disconnect());

            this.buildEffectsChain();

            if (this.effectsChain.length > 0) {
                this.micSource.connect(this.effectsChain[0]);
                this.effectsChain[this.effectsChain.length - 1].connect(this.micGain);
            } else {
                this.micSource.connect(this.micGain);
            }
        }
    }

    setMicVolume(value) {
        this.volumeMic = value;
        if (this.micGain) {
            this.micGain.gain.setTargetAtTime(value, this.audioContext.currentTime, 0.05);
        }
    }

    /**
     * Démarre l'enregistrement du freestyle
     */
    startRecording() {
        if (this.mediaRecorder && this.mediaRecorder.state === 'inactive') {
            this.recordedChunks = [];
            this.mediaRecorder.start();
            return true;
        }
        return false;
    }

    /**
     * Arrête l'enregistrement et retourne le blob
     */
    stopRecording() {
        return new Promise((resolve) => {
            if (this.mediaRecorder && this.mediaRecorder.state !== 'inactive') {
                this.mediaRecorder.onstop = () => {
                    const blob = new Blob(this.recordedChunks, { type: 'audio/webm' });
                    this.recordedChunks = [];
                    resolve(blob);
                };
                this.mediaRecorder.stop();
            } else {
                resolve(null);
            }
        });
    }

    /**
     * Génère un beat de fond (pour le mode freestyle)
     */
    startBeat(beatType) {
        this.stopBeat();
        this.currentBeat = beatType;
        const ctx = this.audioContext;

        const patterns = {
            hiphop: { bpm: 90, kick: [0, 2], snare: [1, 3], hihat: [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5] },
            rock: { bpm: 120, kick: [0, 1, 2, 3], snare: [1, 3], hihat: [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5] },
            electro: { bpm: 128, kick: [0, 1, 2, 3], snare: [1, 3], hihat: [0, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3, 3.25, 3.5, 3.75] },
            pop: { bpm: 110, kick: [0, 1.5, 2, 3], snare: [1, 3], hihat: [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5] }
        };

        const pattern = patterns[beatType] || patterns.hiphop;
        const beatDuration = 60 / pattern.bpm; // durée d'un temps en secondes
        const loopDuration = beatDuration * 4; // boucle de 4 temps

        let startTime = ctx.currentTime;

        const scheduleLoop = () => {
            if (!this.beatInterval) return;

            const now = ctx.currentTime;

            // Kick
            pattern.kick.forEach(time => {
                const osc = ctx.createOscillator();
                const gain = ctx.createGain();
                osc.frequency.setValueAtTime(150, now + time * beatDuration);
                osc.frequency.exponentialRampToValueAtTime(0.01, now + time * beatDuration + 0.5);
                gain.gain.setValueAtTime(0.8, now + time * beatDuration);
                gain.gain.exponentialRampToValueAtTime(0.01, now + time * beatDuration + 0.5);
                osc.connect(gain);
                gain.connect(this.musicGain);
                osc.start(now + time * beatDuration);
                osc.stop(now + time * beatDuration + 0.5);
            });

            // Snare
            pattern.snare.forEach(time => {
                const bufferSize = ctx.sampleRate * 0.2;
                const buffer = ctx.createBuffer(1, bufferSize, ctx.sampleRate);
                const data = buffer.getChannelData(0);
                for (let i = 0; i < bufferSize; i++) {
                    data[i] = Math.random() * 2 - 1;
                }
                const noise = ctx.createBufferSource();
                noise.buffer = buffer;
                const gain = ctx.createGain();
                gain.gain.setValueAtTime(0.4, now + time * beatDuration);
                gain.gain.exponentialRampToValueAtTime(0.01, now + time * beatDuration + 0.2);
                const filter = ctx.createBiquadFilter();
                filter.type = 'highpass';
                filter.frequency.value = 1000;
                noise.connect(filter);
                filter.connect(gain);
                gain.connect(this.musicGain);
                noise.start(now + time * beatDuration);
            });

            // Hi-hat
            pattern.hihat.forEach(time => {
                const bufferSize = ctx.sampleRate * 0.05;
                const buffer = ctx.createBuffer(1, bufferSize, ctx.sampleRate);
                const data = buffer.getChannelData(0);
                for (let i = 0; i < bufferSize; i++) {
                    data[i] = (Math.random() * 2 - 1) * Math.pow(1 - i / bufferSize, 2);
                }
                const noise = ctx.createBufferSource();
                noise.buffer = buffer;
                const gain = ctx.createGain();
                gain.gain.value = 0.15;
                const filter = ctx.createBiquadFilter();
                filter.type = 'highpass';
                filter.frequency.value = 7000;
                noise.connect(filter);
                filter.connect(gain);
                gain.connect(this.musicGain);
                noise.start(now + time * beatDuration);
            });

            startTime += loopDuration;
        };

        scheduleLoop();
        this.beatInterval = setInterval(scheduleLoop, loopDuration * 1000 * 0.9);
    }

    stopBeat() {
        if (this.beatInterval) {
            clearInterval(this.beatInterval);
            this.beatInterval = null;
        }
    }

    /**
     * Retourne les données de fréquence pour la visualisation
     */
    getFrequencyData() {
        if (!this.analyser) return new Uint8Array(128);
        const data = new Uint8Array(this.analyser.frequencyBinCount);
        this.analyser.getByteFrequencyData(data);
        return data;
    }

    /**
     * Retourne les données temporelles (waveform)
     */
    getTimeDomainData() {
        if (!this.analyser) return new Uint8Array(128);
        const data = new Uint8Array(this.analyser.fftSize);
        this.analyser.getByteTimeDomainData(data);
        return data;
    }

    /**
     * Détecte le pitch (fréquence fondamentale) - pour le scoring
     * Utilise l'autocorrélation simplifiée
     */
    detectPitch() {
        if (!this.analyser) return 0;
        const bufferLength = this.analyser.fftSize;
        const buffer = new Float32Array(bufferLength);
        this.analyser.getFloatTimeDomainData(buffer);

        // Autocorrélation simplifiée
        const sampleRate = this.audioContext.sampleRate;
        let bestCorrelation = 0;
        let bestLag = 0;

        for (let lag = 50; lag < 1000; lag++) {
            let correlation = 0;
            for (let i = 0; i < bufferLength - lag; i++) {
                correlation += buffer[i] * buffer[i + lag];
            }
            correlation = correlation / (bufferLength - lag);
            if (correlation > bestCorrelation) {
                bestCorrelation = correlation;
                bestLag = lag;
            }
        }

        if (bestCorrelation > 0.3) {
            return sampleRate / bestLag;
        }
        return 0;
    }

    /**
     * Détecte si du son est présent (pour le scoring de présence)
     */
    getVolume() {
        if (!this.analyser) return 0;
        const data = this.getTimeDomainData();
        let sum = 0;
        for (let i = 0; i < data.length; i++) {
            const val = (data[i] - 128) / 128;
            sum += val * val;
        }
        return Math.sqrt(sum / data.length);
    }

    /**
     * Nettoyage complet
     */
    destroy() {
        this.stopMusic();
        this.stopMic();
        this.stopBeat();
        if (this.audioContext) {
            this.audioContext.close();
            this.audioContext = null;
        }
    }
}

// Instance globale
window.AudioEngine = AudioEngine;
