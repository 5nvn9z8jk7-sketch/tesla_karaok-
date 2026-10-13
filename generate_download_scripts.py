#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Génère les scripts de téléchargement des instrumentaux karaoké
Crée un fichier batch Windows avec les commandes yt-dlp pour les 100 chansons
"""

import os
import json

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
SONGS_DIR = os.path.join(BASE_DIR, 'songs')

# Templates de recherche YouTube (du plus spécifique au plus général)
SEARCH_TEMPLATES = [
    "{title} {artist} karaoke instrumental",
    "{title} {artist} playback",
    "{title} {artist} version karaoké",
    "{title} {artist} backing track",
    "{title} {artist} instrumental",
    "{title} {artist} karaoke",
]

def generate_yt_search_url(title, artist):
    """Génère une URL de recherche YouTube"""
    query = f"{title} {artist} karaoke instrumental".replace(' ', '+')
    return f"https://www.youtube.com/results?search_query={query}"

def generate_ytdlp_command(song_id, title, artist, output_dir):
    """Génère une commande yt-dlp pour télécharger l'instrumental"""
    # Recherche YouTube et téléchargement du premier résultat en MP3
    search_query = f"ytsearch1:{title} {artist} karaoke instrumental"
    output_template = os.path.join(output_dir, "audio.%(ext)s")
    
    cmd = f'yt-dlp -x --audio-format mp3 --audio-quality 0 -o "{output_template}" "{search_query}"'
    return cmd

def main():
    # Charger le manifest
    manifest_path = os.path.join(SONGS_DIR, 'manifest.json')
    with open(manifest_path, 'r', encoding='utf-8') as f:
        manifest = json.load(f)
    
    print(f"Génération des scripts pour {len(manifest)} chansons...")
    
    # ============================================================
    # 1. Fichier batch principal (télécharge tout)
    # ============================================================
    bat_lines = [
        "@echo off",
        "chcp 65001 >nul",
        "echo.",
        "echo =========================================",
        "echo  TELECHARGEMENT DES INSTRUMENTAUX KARAOKE",
        "echo  Tesla Karaoké Party - 100 chansons",
        "echo =========================================",
        "echo.",
        "echo  Ce script télécharge les instrumentaux",
        "echo  depuis YouTube avec yt-dlp.",
        "echo.",
        "echo  PRÉREQUIS :",
        "echo  1. Installer yt-dlp : pip install yt-dlp",
        "echo  2. Installer ffmpeg (requis pour MP3)",
        "echo.",
        "echo  Appuie sur une touche pour commencer...",
        "pause >nul",
        "echo.",
    ]
    
    # Compteurs
    total = len(manifest)
    success = 0
    failed = 0
    
    for i, song in enumerate(manifest, 1):
        song_id = song['id']
        title = song['title']
        artist = song['artist']
        song_dir = os.path.join('songs', song_id)
        
        # Créer le dossier s'il n'existe pas
        os.makedirs(song_dir, exist_ok=True)
        
        bat_lines.append(f'echo [{i}/{total}] {title} - {artist}')
        bat_lines.append(f'mkdir "{song_dir}" 2>nul')
        
        # Commande yt-dlp
        search_query = f"{title} {artist} karaoke instrumental"
        output_template = f"{song_dir}/audio.%(ext)s"
        
        cmd = f'yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "{output_template}" "ytsearch1:{search_query}"'
        bat_lines.append(cmd)
        
        # Vérifier si le fichier a été créé
        bat_lines.append(f'if exist "{song_dir}\\audio.mp3" (')
        bat_lines.append(f'  echo   [OK] Telecharge')
        bat_lines.append(f') else (')
        bat_lines.append(f'  echo   [ECHEC] Non trouve - cherche manuellement')
        bat_lines.append(f')')
        bat_lines.append('')
    
    bat_lines.append('echo.')
    bat_lines.append('echo =========================================')
    bat_lines.append('echo  TELECHARGEMENT TERMINE')
    bat_lines.append('echo =========================================')
    bat_lines.append('echo.')
    bat_lines.append('pause')
    
    # Écrire le fichier batch
    bat_path = os.path.join(BASE_DIR, 'download_all.bat')
    with open(bat_path, 'w', encoding='utf-8') as f:
        f.write('\r\n'.join(bat_lines))
    print(f"  [OK] {bat_path}")
    
    # ============================================================
    # 2. Fichier JSON avec les liens de recherche YouTube
    # ============================================================
    sources = []
    for song in manifest:
        sources.append({
            "id": song['id'],
            "title": song['title'],
            "artist": song['artist'],
            "searchUrl": generate_yt_search_url(song['title'], song['artist']),
            "searchQueries": [
                f"{song['title']} {song['artist']} karaoke instrumental",
                f"{song['title']} {song['artist']} playback",
                f"{song['title']} {song['artist']} backing track",
            ],
            "outputPath": f"songs/{song['id']}/audio.mp3"
        })
    
    sources_path = os.path.join(SONGS_DIR, 'karaoke-sources.json')
    with open(sources_path, 'w', encoding='utf-8') as f:
        json.dump(sources, f, ensure_ascii=False, indent=2)
    print(f"  [OK] {sources_path}")
    
    # ============================================================
    # 3. Script Python alternatif (pour Linux/Mac)
    # ============================================================
    sh_lines = [
        "#!/bin/bash",
        "# Téléchargement des instrumentaux karaoké",
        "# Usage: ./download_all.sh",
        "",
        "cd \"$(dirname \"$0\")\"",
        "",
        "echo \"=========================================\"",
        "echo \" TELECHARGEMENT DES INSTRUMENTAUX KARAOKE\"",
        "echo \"=========================================\"",
        "",
    ]
    
    for i, song in enumerate(manifest, 1):
        song_id = song['id']
        title = song['title']
        artist = song['artist']
        song_dir = f"songs/{song_id}"
        
        sh_lines.append(f'echo "[{i}/{total}] {title} - {artist}"')
        sh_lines.append(f'mkdir -p "{song_dir}"')
        sh_lines.append(f'yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "{song_dir}/audio.%(ext)s" "ytsearch1:{title} {artist} karaoke instrumental"')
        sh_lines.append(f'if [ -f "{song_dir}/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi')
        sh_lines.append('')
    
    sh_lines.append('echo "Termine!"')
    
    sh_path = os.path.join(BASE_DIR, 'download_all.sh')
    with open(sh_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(sh_lines))
    os.chmod(sh_path, 0o755)
    print(f"  [OK] {sh_path}")
    
    # ============================================================
    # 4. Script d'installation des prérequis
    # ============================================================
    install_lines = [
        "@echo off",
        "chcp 65001 >nul",
        "echo.",
        "echo =========================================",
        "echo  INSTALLATION DES PREREQUIS",
        "echo =========================================",
        "echo.",
        "echo  1. Installation de yt-dlp...",
        "pip install yt-dlp",
        "echo.",
        "echo  2. Verification de ffmpeg...",
        "ffmpeg -version >nul 2>&1",
        "if %errorlevel% neq 0 (",
        "    echo  ffmpeg non trouve. Telecharge-le sur https://ffmpeg.org/download.html",
        "    echo  et ajoute-le au PATH.",
        ") else (",
        "    echo  [OK] ffmpeg est installe",
        ")",
        "echo.",
        "echo  3. Mise a jour de yt-dlp...",
        "yt-dlp -U",
        "echo.",
        "echo =========================================",
        "echo  INSTALLATION TERMINEE",
        "echo  Tu peux maintenant lancer download_all.bat",
        "echo =========================================",
        "pause",
    ]
    
    install_path = os.path.join(BASE_DIR, 'install_deps.bat')
    with open(install_path, 'w', encoding='utf-8') as f:
        f.write('\r\n'.join(install_lines))
    print(f"  [OK] {install_path}")
    
    print(f"\n{'='*50}")
    print("  FICHIERS GENERES :")
    print(f"{'='*50}")
    print(f"  1. install_deps.bat   - Installe yt-dlp et verifie ffmpeg")
    print(f"  2. download_all.bat   - Telecharge les 100 instrumentaux")
    print(f"  3. download_all.sh    - Version Linux/Mac")
    print(f"  4. songs/karaoke-sources.json - Liens de recherche YouTube")
    print(f"\n  UTILISATION :")
    print(f"  1. Double-clique sur install_deps.bat")
    print(f"  2. Double-clique sur download_all.bat")
    print(f"  3. Attends la fin du telechargement (~10-30 min)")
    print(f"  4. git add . && git commit -m 'Instrumentaux' && git push")
    print(f"{'='*50}")

if __name__ == '__main__':
    main()
