# Guide : Obtenir les vraies chansons (instrumentaux karaoké)

Ce guide t'explique comment remplacer les démos automatiques par les **vraies versions instrumentales** (sans voix) des 100 chansons françaises.

## Méthode automatique (recommandée)

### 1. Installer les prérequis

Double-clique sur **`install_deps.bat`** à la racine du projet.

Ou en ligne de commande :
```bash
pip install yt-dlp
# ffmpeg est aussi requis (voir https://ffmpeg.org/download.html)
```

### 2. Télécharger les instrumentaux

Double-clique sur **`download.bat`**.

Le script va :
- Chercher chaque chanson sur YouTube ("[titre] [artiste] karaoke instrumental")
- Télécharger l'audio en MP3 (qualité max)
- Placer le fichier dans `songs/[id-chanson]/audio.mp3`

**Durée estimée** : 10-30 minutes pour les 100 chansons (selon ta connexion).

### 3. Pousser les changements

```bash
git add .
git commit -m "Ajout des instrumentaux karaoké"
git push
```

Le site GitHub Pages se met à jour automatiquement. Dans ta Tesla, recharge la page (F5 ou tire vers le bas).

---

## Méthode manuelle (pour une chanson spécifique)

Si le téléchargement auto échoue pour certaines chansons :

### 1. Trouver l'instrumental sur YouTube

Ouvre ce lien (généré automatiquement) :
```
songs/karaoke-sources.json
```

Ou cherche manuellement sur YouTube :
- `[titre] [artiste] karaoke instrumental`
- `[titre] [artiste] playback`
- `[titre] [artiste] backing track`

### 2. Télécharger en MP3

**Option A — yt-dlp (ligne de commande)** :
```bash
yt-dlp -x --audio-format mp3 --audio-quality 0 -o "songs/[id-chanson]/audio.%(ext)s" "URL_YOUTUBE"
```

**Option B — Site web** :
- [ytmp3.nu](https://ytmp3.nu) (colle l'URL YouTube, télécharge en MP3)
- [cobalt.tools](https://cobalt.tools)

### 3. Placer le fichier

Renomme le fichier téléchargé en `audio.mp3` et place-le dans :
```
songs/[id-chanson]/audio.mp3
```

Exemple pour "La Vie en Rose" :
```
songs/vie-en-rose/audio.mp3
```

---

## Comment l'app gère les fichiers

Pour chaque chanson, l'app cherche dans cet ordre :

1. **`songs/[id]/audio.mp3`** — Ton instrumental perso (prioritaire)
2. **`songs/_demo_[style].wav`** — Démo automatique (fallback)

Donc tant que tu n'as pas téléchargé l'instrumental, la démo est utilisée. Dès que tu ajoutes `audio.mp3`, c'est celui-ci qui est joué.

---

## Conseils pour trouver les meilleurs instrumentaux

| Recherche YouTube | Qualité | Exemple |
|---|---|---|
| `[titre] karaoke instrumental` | ⭐⭐⭐ Bonne | "La vie en rose karaoke instrumental" |
| `[titre] playback` | ⭐⭐⭐ Officiel | "Papaoutai playback" |
| `[titre] backing track` | ⭐⭐⭐ Pro | "Formidable backing track" |
| `[titre] karaoke version` | ⭐⭐☆ Variable | "Je veux karaoke version" |
| `[titre] instrumental` | ⭐⭐☆ Souvent avec voix | À vérifier |

**Chaînes YouTube spécialisées** :
- Karaoke Version
- Sing King Karaoke
- Karaoke On VEVO
- Music City (playbacks officiels)

---

## Structure des dossiers

```
songs/
├── _demo_variete.wav          # Démo variété (fallback)
├── _demo_rock.wav             # Démo rock (fallback)
├── _demo_pop.wav              # Démo pop (fallback)
├── _demo_electro.wav          # Démo électro (fallback)
├── _demo_rap.wav              # Démo rap (fallback)
├── manifest.json              # Liste des 100 chansons
├── karaoke-sources.json       # Liens de recherche YouTube
├── vie-en-rose/
│   ├── lyrics.lrc             # Paroles synchronisées
│   └── audio.mp3              # ← Ton instrumental (à ajouter)
├── papaoutai/
│   ├── lyrics.lrc
│   └── audio.mp3              # ← Ton instrumental (à ajouter)
└── ...
```

---

## Dépannage

| Problème | Solution |
|---|---|
| `yt-dlp` non reconnu | `pip install yt-dlp` puis redémarre le terminal |
| ffmpeg non trouvé | Installe ffmpeg et ajoute-le au PATH |
| Vidéo YouTube inaccessible | Essaie une autre recherche ou télécharge manuellement |
| Qualité audio faible | Utilise `--audio-quality 0` (déjà dans le script) |
| Chanson non trouvée | Cherche manuellement sur YouTube et télécharge à la main |

---

## Alternative : Utiliser Spotify/Apple Music

Certaines chansons ont des versions instrumentales officielles sur :
- **Spotify** : cherche "[titre] piano version" ou "[titre] instrumental"
- **Apple Music** : idem
- **Deezer** : idem

Tu peux ensuite télécharger avec les mêmes outils (yt-dlp supporte aussi Spotify avec authentification).
