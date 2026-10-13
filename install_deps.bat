@echo off
chcp 65001 >nul
echo.
echo =========================================
echo  INSTALLATION DES PREREQUIS
echo =========================================
echo.
echo  1. Installation de yt-dlp...
pip install yt-dlp
echo.
echo  2. Verification de ffmpeg...
ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo  ffmpeg non trouve. Telecharge-le sur https://ffmpeg.org/download.html
    echo  et ajoute-le au PATH.
) else (
    echo  [OK] ffmpeg est installe
)
echo.
echo  3. Mise a jour de yt-dlp...
yt-dlp -U
echo.
echo =========================================
echo  INSTALLATION TERMINEE
echo  Tu peux maintenant lancer download_all.bat
echo =========================================
pause