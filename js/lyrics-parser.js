/**
 * Tesla Karaoké Party - Parseur de paroles LRC
 * Parse les fichiers .lrc (synchronisés) et fournit les paroles par timestamp
 */

class LyricsParser {
    constructor() {
        this.lines = []; // [{ time: 12.5, text: "parole..." }, ...]
        this.metadata = {}; // { ti: "Titre", ar: "Artiste", al: "Album", ... }
    }

    /**
     * Parse une chaîne LRC
     * Format: [mm:ss.xx]parole
     * Plusieurs timestamps par ligne supportés: [00:12.00][00:45.00]parole répétée
     */
    parse(lrcContent) {
        this.lines = [];
        this.metadata = {};

        const lines = lrcContent.split('\n');
        const timeRegex = /\[(\d{1,2}):(\d{2})(?:[.:](\d{2,3}))?\]/g;
        const metaRegex = /\[(\w+):(.*?)\]/;

        for (const line of lines) {
            const trimmed = line.trim();
            if (!trimmed) continue;

            // Métadonnées (ti, ar, al, by, offset, etc.)
            const metaMatch = trimmed.match(metaRegex);
            if (metaMatch && !timeRegex.test(trimmed)) {
                this.metadata[metaMatch[1]] = metaMatch[2].trim();
                timeRegex.lastIndex = 0;
                continue;
            }

            // Lignes avec timestamps
            const matches = [...trimmed.matchAll(/\[(\d{1,2}):(\d{2})(?:[.:](\d{2,3}))?\]/g)];
            if (matches.length === 0) continue;

            // Texte après les timestamps
            const text = trimmed.replace(/\[\d{1,2}:\d{2}(?:[.:]\d{2,3})?\]/g, '').trim();

            for (const match of matches) {
                const minutes = parseInt(match[1]);
                const seconds = parseInt(match[2]);
                const centiseconds = match[3] ? parseInt(match[3]) : 0;
                const time = minutes * 60 + seconds + centiseconds / (match[3] && match[3].length === 3 ? 1000 : 100);

                this.lines.push({ time, text });
            }

            timeRegex.lastIndex = 0;
        }

        // Trier par temps
        this.lines.sort((a, b) => a.time - b.time);

        // Appliquer l'offset si présent
        if (this.metadata.offset) {
            const offset = parseInt(this.metadata.offset) / 1000;
            this.lines.forEach(line => line.time += offset);
        }

        return this;
    }

    /**
     * Charge un fichier LRC depuis une URL
     */
    async load(url) {
        const response = await fetch(url);
        const content = await response.text();
        return this.parse(content);
    }

    /**
     * Retourne l'index de la ligne active à un temps donné
     * -1 si avant la première ligne
     */
    getActiveLineIndex(currentTime) {
        if (this.lines.length === 0) return -1;

        for (let i = this.lines.length - 1; i >= 0; i--) {
            if (currentTime >= this.lines[i].time) {
                return i;
            }
        }
        return -1;
    }

    /**
     * Retourne la ligne active à un temps donné
     */
    getActiveLine(currentTime) {
        const index = this.getActiveLineIndex(currentTime);
        return index >= 0 ? this.lines[index] : null;
    }

    /**
     * Retourne les N prochaines lignes à partir du temps actuel
     */
    getUpcomingLines(currentTime, count = 3) {
        const activeIndex = this.getActiveLineIndex(currentTime);
        const result = [];

        for (let i = activeIndex + 1; i < Math.min(activeIndex + 1 + count, this.lines.length); i++) {
            result.push(this.lines[i]);
        }

        return result;
    }

    /**
     * Retourne la progression dans la ligne active (0 à 1)
     * Basé sur le temps jusqu'à la ligne suivante
     */
    getLineProgress(currentTime) {
        const activeIndex = this.getActiveLineIndex(currentTime);
        if (activeIndex < 0 || activeIndex >= this.lines.length - 1) return 0;

        const currentLine = this.lines[activeIndex];
        const nextLine = this.lines[activeIndex + 1];
        const duration = nextLine.time - currentLine.time;
        const elapsed = currentTime - currentLine.time;

        return Math.min(Math.max(elapsed / duration, 0), 1);
    }

    /**
     * Retourne la durée totale (dernier timestamp)
     */
    getTotalDuration() {
        if (this.lines.length === 0) return 0;
        return this.lines[this.lines.length - 1].time;
    }

    /**
     * Retourne toutes les lignes
     */
    getLines() {
        return this.lines;
    }

    /**
     * Retourne les métadonnées
     */
    getMetadata() {
        return this.metadata;
    }

    /**
     * Génère un contenu LRC à partir de lignes (pour export)
     */
    static generate(lines, metadata = {}) {
        let lrc = '';

        // Métadonnées
        for (const [key, value] of Object.entries(metadata)) {
            lrc += `[${key}:${value}]\n`;
        }

        // Lignes
        for (const line of lines) {
            const minutes = Math.floor(line.time / 60);
            const seconds = Math.floor(line.time % 60);
            const centiseconds = Math.floor((line.time % 1) * 100);
            const timeStr = `[${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}.${String(centiseconds).padStart(2, '0')}]`;
            lrc += `${timeStr}${line.text}\n`;
        }

        return lrc;
    }
}

// Instance globale
window.LyricsParser = LyricsParser;
