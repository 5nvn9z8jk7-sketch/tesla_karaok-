@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo.
echo =========================================
echo  INSTALLATION DES PREREQUIS
echo =========================================
echo.
echo  1. Installation de yt-dlp...
pip install yt-dlp
echo.
echo  2. Installation de ffmpeg (via imageio-ffmpeg)...
pip install imageio-ffmpeg
echo.
echo  3. Copie de ffmpeg dans le projet...
python -c "import imageio_ffmpeg, shutil, os; src = imageio_ffmpeg.get_ffmpeg_exe(); dst = os.path.join(os.path.dirname(os.path.abspath('install_deps.bat')), 'ffmpeg.exe'); shutil.copy2(src, dst); print(f'ffmpeg copie dans {dst}')"
if exist "ffmpeg.exe" (
    echo  [OK] ffmpeg.exe est pret
) else (
    echo  [ERREUR] ffmpeg.exe non copie. Verifie l'installation.
)
echo.
echo  4. Mise a jour de yt-dlp...
yt-dlp -U
echo.
echo =========================================
echo  INSTALLATION TERMINEE
echo  Tu peux maintenant lancer download.bat
echo =========================================
pause
