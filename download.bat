@echo off
chcp 65001 >nul
echo.
echo =========================================
echo  TESLA KARAOKE - Telechargement des musiques
echo =========================================
echo.
echo  Ce script telecharge les instrumentaux manquants
cd /d "%~dp0"

REM Verifier que yt-dlp est installe
where yt-dlp >nul 2>&1
if %errorlevel% neq 0 (
    echo  ERREUR: yt-dlp n'est pas installe.
    echo  Installe-le avec : pip install yt-dlp
    pause
    exit /b 1
)

REM Verifier que ffmpeg.exe est present
if not exist "ffmpeg.exe" (
    echo  ERREUR: ffmpeg.exe non trouve dans le projet.
    echo  Telecharge ffmpeg ou execute install_deps.bat
    pause
    exit /b 1
)

echo  Lancement du telechargement...
echo  (les chansons deja telechargees seront ignorees)
echo.
python download_songs.py %*

echo.
echo =========================================
echo  Termine !
echo  Lance start.bat pour tester l'application.
echo =========================================
echo.
pause
