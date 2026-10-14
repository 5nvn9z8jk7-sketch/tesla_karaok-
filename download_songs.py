#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Télécharge les instrumentaux karaoké manquants depuis YouTube.
Usage: python download_songs.py [--all] [--test]
  --all   : télécharge les 100 chansons (même celles déjà présentes)
  --test  : télécharge seulement 5 chansons pour tester
  (défaut): télécharge uniquement les chansons sans audio.mp3
"""

import json
import os
import subprocess
import sys
from pathlib import Path

# Chemins
ROOT = Path(__file__).parent
SONGS_DIR = ROOT / "songs"
MANIFEST = SONGS_DIR / "manifest.json"
FFMPEG = ROOT / "ffmpeg.exe"

# Options yt-dlp
YT_OPTS = [
    "-x", "--audio-format", "mp3", "--audio-quality", "0",
    "--no-playlist",
    "--ffmpeg-location", str(FFMPEG),
    "--no-warnings",
    "-q",
]


def load_manifest():
    with open(MANIFEST, "r", encoding="utf-8") as f:
        return json.load(f)


def has_audio(song_id):
    """Vérifie si la chanson a déjà un fichier audio."""
    song_dir = SONGS_DIR / song_id
    return (song_dir / "audio.mp3").exists() or (song_dir / "audio.wav").exists()


def download_song(song):
    """Télécharge l'instrumental d'une chanson."""
    song_dir = SONGS_DIR / song["id"]
    song_dir.mkdir(parents=True, exist_ok=True)

    title = song["title"]
    artist = song["artist"]

    # Construire les requêtes de recherche (3 stratégies)
    queries = [
        f"{title} {artist} karaoke instrumental",
        f"{title} {artist} playback",
        f"{title} {artist} backing track",
    ]

    output_template = str(song_dir / "audio.%(ext)s")

    for i, query in enumerate(queries):
        strategy = ["karaoke instrumental", "playback", "backing track"][i]
        print(f"    Essai {i+1}/3 ({strategy})...", end=" ", flush=True)

        cmd = ["yt-dlp", *YT_OPTS, "-o", output_template, f"ytsearch1:{query}"]

        try:
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=120)
            if (song_dir / "audio.mp3").exists():
                size_mb = (song_dir / "audio.mp3").stat().st_size / (1024 * 1024)
                print(f"OK ({size_mb:.1f} Mo)")
                return True
            else:
                print("pas de fichier")
        except subprocess.TimeoutExpired:
            print("timeout")
        except Exception as e:
            print(f"erreur: {e}")

    print("    ECHEC - tous les essais ont echoue")
    return False


def main():
    args = sys.argv[1:]
    force_all = "--all" in args
    test_mode = "--test" in args

    songs = load_manifest()

    # Filtrer les chansons à télécharger
    if force_all:
        to_download = songs
    elif test_mode:
        to_download = [s for s in songs if not has_audio(s["id"])][:5]
    else:
        to_download = [s for s in songs if not has_audio(s["id"])]

    already_have = len(songs) - len(to_download)

    print("=" * 55)
    print("  TESLA KARAOKE - Telechargement des instrumentaux")
    print("=" * 55)
    print(f"  Total chansons    : {len(songs)}")
    print(f"  Deja telechargees  : {already_have}")
    print(f"  A telecharger      : {len(to_download)}")
    if test_mode:
        print("  Mode               : TEST (5 chansons)")
    print("=" * 55)
    print()

    if not to_download:
        print("Toutes les chansons ont deja leur instrumental !")
        return

    success = 0
    failed = []

    for i, song in enumerate(to_download, 1):
        print(f"[{i}/{len(to_download)}] {song['title']} - {song['artist']}")
        if download_song(song):
            success += 1
        else:
            failed.append(f"{song['title']} - {song['artist']}")
        print()

    print("=" * 55)
    print("  RESUME")
    print("=" * 55)
    print(f"  Reussis  : {success}/{len(to_download)}")
    print(f"  Echoues  : {len(failed)}/{len(to_download)}")
    total_with_audio = already_have + success
    print(f"  Total avec audio : {total_with_audio}/{len(songs)}")

    if failed:
        print()
        print("  Chansons en echec (a telecharger manuellement) :")
        for f in failed:
            print(f"    - {f}")

    print()
    print("Pour lancer le serveur local : start.bat")
    print("Ou : python -m http.server 8765")


if __name__ == "__main__":
    main()
