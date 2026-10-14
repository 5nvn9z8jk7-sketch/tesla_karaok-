# Tesla Karaoké Party

Application web de karaoké conçue pour l'écran tactile 15" de la Tesla Model Y (2200×1300, paysage).

> **100 chansons françaises incluses** avec paroles synchronisées. Pour obtenir les vraies versions instrumentales (karaoké), suis le guide rapide ci-dessous ou consulte [KARAOKE_GUIDE.md](KARAOKE_GUIDE.md).

## Quick Start : Vraies chansons en 3 étapes

```bash
# 1. Installer les dépendances (yt-dlp + ffmpeg)
install_deps.bat

# 2. Télécharger les 100 instrumentaux depuis YouTube (~10-30 min)
download.bat

# 3. Pousser sur GitHub (le site se met à jour automatiquement)
git add . && git commit -m "Instrumentaux" && git push
```

## Fonctionnalités

| Mode | Description |
|------|-------------|
| **Solo** | Chante une chanson avec paroles synchronisées et scoring en temps réel |
| **Duel** | 2 joueurs s'affrontent, chacun chante les lignes paires/impaires |
| **Blind Test** | Devine le titre à partir d'un extrait de 10 secondes |
| **Free Style** | Improvise sur un beat généré (Hip-Hop, Rock, Électro, Pop) avec effets vocaux |

### Effets vocaux (Free Style)
- Normal
- Écho (delay + feedback)
- Robot (ring modulation)
- Distortion (waveshaper)

### Scoring
- Analyse du volume et du pitch en temps réel via Web Audio API
- Système de combo et streak
- Rangs de S (légende) à F (débutant)
- Étoiles de 0 à 5

## Structure du projet

```
tesla-karaoke/
├── index.html              # Interface principale
├── css/
│   └── style.css           # Design sombre, tactile, responsive
├── js/
│   ├── app.js              # Navigation et état global
│   ├── audio-engine.js     # Moteur audio (Web Audio API)
│   ├── lyrics-parser.js    # Parseur LRC (paroles synchronisées)
│   ├── scoring.js          # Système de scoring
│   └── games/
│       ├── solo.js         # Mode solo
│       ├── duel.js         # Mode duel 2 joueurs
│       ├── blindtest.js    # Mode blind test
│       └── freestyle.js    # Mode free style
├── songs/
│   ├── manifest.json       # Liste des chansons
│   └── demo/
│       ├── audio.wav       # Morceau de démo (généré)
│       └── lyrics.lrc      # Paroles synchronisées (format LRC)
└── README.md
```

## Utilisation dans la Tesla

### Méthode 1 : GitHub Pages (recommandé, gratuit)

1. Crée un dépôt GitHub
2. Pousse ce projet
3. Active GitHub Pages (Settings → Pages → Source: main branch)
4. Dans la Tesla, ouvre le navigateur et va sur `https://ton-username.github.io/tesla-karaoke`

### Méthode 2 : Vercel / Netlify (gratuit)

1. Va sur [vercel.com](https://vercel.com) ou [netlify.com](https://netlify.com)
2. Connecte ton dépôt GitHub ou upload le dossier
3. Déploie en 1 clic
4. Ouvre l'URL dans le navigateur Tesla

### Méthode 3 : Serveur local (développement)

```bash
# Avec Python
cd tesla-karaoke
python -m http.server 8000

# Avec Node.js (npx)
npx serve .

# Avec PHP
php -S localhost:8000
```

Puis ouvre `http://localhost:8000` (ou l'IP de ton PC depuis la Tesla, ex: `http://192.168.1.42:8000`)

## Ajouter tes propres chansons

Pour chaque chanson, crée un dossier dans `songs/` :

```
songs/ma-chanson/
├── audio.mp3       # L'instrumental (sans voix)
└── lyrics.lrc      # Les paroles synchronisées
```

### Format LRC (paroles synchronisées)

```
[ti:Titre de la chanson]
[ar:Artiste]
[00:00.50]Première ligne des paroles
[00:03.20]Deuxième ligne
[00:06.00]Troisième ligne
```

Format du timestamp : `[mm:ss.xx]` (minutes:secondes.centièmes)

### Mettre à jour le manifest

Ajoute ta chanson dans `songs/manifest.json` :

```json
{
    "id": "ma-chanson",
    "title": "Titre",
    "artist": "Artiste",
    "difficulty": "easy",
    "audioUrl": "songs/ma-chanson/audio.mp3",
    "lyricsUrl": "songs/ma-chanson/lyrics.lrc"
}
```

### Outils pour créer des fichiers LRC

- **MiniLyrics** (Windows) : synchronise les paroles sur de la musique
- **Karaoke 5** (Windows/Mac) : éditeur LRC complet
- **Site web** : [lrcgenerator.com](https://lrcgenerator.com) ou [megalobiz.com](https://megalobiz.com/lrc/maker)
- **Extension VS Code** : "LRC maker" pour synchroniser manuellement

## Obtenir des instrumentaux (karaoké)

- **YouTube** : cherche "[titre] karaoke instrumental" ou "[titre] backing track"
- **Spotify** : certaines playlists "Karaoke" existent
- **Sites spécialisés** : Karaoke Version, Sing King (YouTube)
- **Ultimate Vocal Remover** (gratuit) : sépare la voix de la musique pour créer un instrumental

## Conseils d'utilisation dans la Tesla

1. **Mode sombre** : reste actif par défaut (conduite de nuit)
2. **Volume** : règle le volume de la musique dans les réglages avant de commencer
3. **Micro** : la Tesla a un micro intégré, mais un micro externe (jack ou Bluetooth) donne de meilleurs résultats
4. **Mode Duel** : fonctionne mieux avec 2 téléphones/micros Bluetooth connectés, ou en alternance
5. **Sauvegarde** : les scores ne sont pas sauvegardés (mode hors-ligne)

## Technologies utilisées

- **HTML5** : structure sémantique
- **CSS3** : design responsive, animations, thèmes
- **JavaScript ES6+** : logique applicative
- **Web Audio API** : traitement audio, effets, visualisation
- **MediaDevices API** : capture micro
- **MediaRecorder API** : enregistrement audio
- **Web Speech API** (optionnel) : reconnaissance vocale

## Limitations connues

- Le navigateur Tesla peut bloquer l'autoplay audio (interaction utilisateur requise)
- Le micro de la Tesla est optimisé pour les appels, pas pour le chant
- Pas de sauvegarde des scores (prévu dans une future version)
- Le mode Duel avec 2 micros simultanés nécessite 2 sources audio distinctes

## Licence

Projet personnel - libre d'utilisation et de modification.
