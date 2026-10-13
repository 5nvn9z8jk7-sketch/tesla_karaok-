@echo off
chcp 65001 >nul
echo.
echo ========================================
echo   TESLA KARAOKE PARTY - Serveur local
echo ========================================
echo.
echo Demarrage du serveur sur http://localhost:8765
echo.
echo Pour tester depuis ta Tesla (meme Wi-Fi) :
echo   http://%COMPUTERNAME%:8765
echo   ou http://[IP-de-ton-PC]:8765
echo.
echo Appuie sur Ctrl+C pour arreter le serveur.
echo ========================================
echo.

cd /d "%~dp0"
python -m http.server 8765
