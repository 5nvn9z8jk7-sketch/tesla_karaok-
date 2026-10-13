@echo off
chcp 65001 >nul
echo.
echo =========================================
echo  TELECHARGEMENT DES INSTRUMENTAUX KARAOKE
echo  Tesla Karaoké Party - 100 chansons
echo =========================================
echo.
echo  Ce script télécharge les instrumentaux
echo  depuis YouTube avec yt-dlp.
echo.
echo  PRÉREQUIS :
echo  1. Installer yt-dlp : pip install yt-dlp
echo  2. Installer ffmpeg (requis pour MP3)
echo.
echo  Appuie sur une touche pour commencer...
pause >nul
echo.
echo [1/100] La Vie en Rose - Édith Piaf
mkdir "songs\vie-en-rose" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\vie-en-rose/audio.%(ext)s" "ytsearch1:La Vie en Rose Édith Piaf karaoke instrumental"
if exist "songs\vie-en-rose\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [2/100] Non, je ne regrette rien - Édith Piaf
mkdir "songs\ne-regrette-rien" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\ne-regrette-rien/audio.%(ext)s" "ytsearch1:Non, je ne regrette rien Édith Piaf karaoke instrumental"
if exist "songs\ne-regrette-rien\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [3/100] Sous le ciel de Paris - Édith Piaf
mkdir "songs\sous-ciel-paris" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\sous-ciel-paris/audio.%(ext)s" "ytsearch1:Sous le ciel de Paris Édith Piaf karaoke instrumental"
if exist "songs\sous-ciel-paris\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [4/100] Milord - Édith Piaf
mkdir "songs\milord" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\milord/audio.%(ext)s" "ytsearch1:Milord Édith Piaf karaoke instrumental"
if exist "songs\milord\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [5/100] L'hymne à l'amour - Édith Piaf
mkdir "songs\hymne-amour" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\hymne-amour/audio.%(ext)s" "ytsearch1:L'hymne à l'amour Édith Piaf karaoke instrumental"
if exist "songs\hymne-amour\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [6/100] La Bohème - Charles Aznavour
mkdir "songs\boheme" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\boheme/audio.%(ext)s" "ytsearch1:La Bohème Charles Aznavour karaoke instrumental"
if exist "songs\boheme\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [7/100] Emmenez-moi - Charles Aznavour
mkdir "songs\emmenez-moi" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\emmenez-moi/audio.%(ext)s" "ytsearch1:Emmenez-moi Charles Aznavour karaoke instrumental"
if exist "songs\emmenez-moi\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [8/100] Hier encore - Charles Aznavour
mkdir "songs\hier-encore" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\hier-encore/audio.%(ext)s" "ytsearch1:Hier encore Charles Aznavour karaoke instrumental"
if exist "songs\hier-encore\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [9/100] La Mamma - Charles Aznavour
mkdir "songs\la-mamma" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\la-mamma/audio.%(ext)s" "ytsearch1:La Mamma Charles Aznavour karaoke instrumental"
if exist "songs\la-mamma\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [10/100] She - Charles Aznavour
mkdir "songs\she" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\she/audio.%(ext)s" "ytsearch1:She Charles Aznavour karaoke instrumental"
if exist "songs\she\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [11/100] L'été indien - Joe Dassin
mkdir "songs\ete-indien" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\ete-indien/audio.%(ext)s" "ytsearch1:L'été indien Joe Dassin karaoke instrumental"
if exist "songs\ete-indien\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [12/100] Les Champs-Élysées - Joe Dassin
mkdir "songs\champs-elysees" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\champs-elysees/audio.%(ext)s" "ytsearch1:Les Champs-Élysées Joe Dassin karaoke instrumental"
if exist "songs\champs-elysees\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [13/100] Salut les amoureux - Joe Dassin
mkdir "songs\salut-amoureux" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\salut-amoureux/audio.%(ext)s" "ytsearch1:Salut les amoureux Joe Dassin karaoke instrumental"
if exist "songs\salut-amoureux\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [14/100] Le petit pain au chocolat - Joe Dassin
mkdir "songs\petit-pain" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\petit-pain/audio.%(ext)s" "ytsearch1:Le petit pain au chocolat Joe Dassin karaoke instrumental"
if exist "songs\petit-pain\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [15/100] Siffler sur la colline - Joe Dassin
mkdir "songs\siffler-colline" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\siffler-colline/audio.%(ext)s" "ytsearch1:Siffler sur la colline Joe Dassin karaoke instrumental"
if exist "songs\siffler-colline\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [16/100] Les feuilles mortes - Yves Montand
mkdir "songs\feuilles-mortes" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\feuilles-mortes/audio.%(ext)s" "ytsearch1:Les feuilles mortes Yves Montand karaoke instrumental"
if exist "songs\feuilles-mortes\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [17/100] C'est si bon - Yves Montand
mkdir "songs\cest-si-bon" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\cest-si-bon/audio.%(ext)s" "ytsearch1:C'est si bon Yves Montand karaoke instrumental"
if exist "songs\cest-si-bon\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [18/100] La mer - Charles Trenet
mkdir "songs\la-mer" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\la-mer/audio.%(ext)s" "ytsearch1:La mer Charles Trenet karaoke instrumental"
if exist "songs\la-mer\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [19/100] Douce France - Charles Trenet
mkdir "songs\douce-france" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\douce-france/audio.%(ext)s" "ytsearch1:Douce France Charles Trenet karaoke instrumental"
if exist "songs\douce-france\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [20/100] Boum ! - Charles Trenet
mkdir "songs\boum" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\boum/audio.%(ext)s" "ytsearch1:Boum ! Charles Trenet karaoke instrumental"
if exist "songs\boum\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [21/100] Poupée de cire, poupée de son - France Gall
mkdir "songs\poupee-cire" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\poupee-cire/audio.%(ext)s" "ytsearch1:Poupée de cire, poupée de son France Gall karaoke instrumental"
if exist "songs\poupee-cire\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [22/100] Ella, elle l'a - France Gall
mkdir "songs\ella-elle-la" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\ella-elle-la/audio.%(ext)s" "ytsearch1:Ella, elle l'a France Gall karaoke instrumental"
if exist "songs\ella-elle-la\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [23/100] Babacar - France Gall
mkdir "songs\babacar" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\babacar/audio.%(ext)s" "ytsearch1:Babacar France Gall karaoke instrumental"
if exist "songs\babacar\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [24/100] Diego, libre dans sa tête - France Gall
mkdir "songs\diego" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\diego/audio.%(ext)s" "ytsearch1:Diego, libre dans sa tête France Gall karaoke instrumental"
if exist "songs\diego\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [25/100] La groupie du pianiste - Michel Berger
mkdir "songs\groupie-pianiste" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\groupie-pianiste/audio.%(ext)s" "ytsearch1:La groupie du pianiste Michel Berger karaoke instrumental"
if exist "songs\groupie-pianiste\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [26/100] Quelques mots d'amour - Michel Berger
mkdir "songs\quelques-mots" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\quelques-mots/audio.%(ext)s" "ytsearch1:Quelques mots d'amour Michel Berger karaoke instrumental"
if exist "songs\quelques-mots\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [27/100] Un peu de blues - Michel Berger
mkdir "songs\peu-de-blues" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\peu-de-blues/audio.%(ext)s" "ytsearch1:Un peu de blues Michel Berger karaoke instrumental"
if exist "songs\peu-de-blues\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [28/100] Les lacs du Connemara - Michel Sardou
mkdir "songs\lacs-connemara" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\lacs-connemara/audio.%(ext)s" "ytsearch1:Les lacs du Connemara Michel Sardou karaoke instrumental"
if exist "songs\lacs-connemara\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [29/100] Je vais t'aimer - Michel Sardou
mkdir "songs\je-vais-t-aimer" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\je-vais-t-aimer/audio.%(ext)s" "ytsearch1:Je vais t'aimer Michel Sardou karaoke instrumental"
if exist "songs\je-vais-t-aimer\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [30/100] Être une femme - Michel Sardou
mkdir "songs\etre-une-femme" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\etre-une-femme/audio.%(ext)s" "ytsearch1:Être une femme Michel Sardou karaoke instrumental"
if exist "songs\etre-une-femme\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [31/100] Les villes de solitude - Michel Sardou
mkdir "songs\villes-solitude" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\villes-solitude/audio.%(ext)s" "ytsearch1:Les villes de solitude Michel Sardou karaoke instrumental"
if exist "songs\villes-solitude\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [32/100] La maladie d'amour - Michel Sardou
mkdir "songs\maladie-amour" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\maladie-amour/audio.%(ext)s" "ytsearch1:La maladie d'amour Michel Sardou karaoke instrumental"
if exist "songs\maladie-amour\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [33/100] Envole-moi - Jean-Jacques Goldman
mkdir "songs\envole-moi" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\envole-moi/audio.%(ext)s" "ytsearch1:Envole-moi Jean-Jacques Goldman karaoke instrumental"
if exist "songs\envole-moi\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [34/100] Je marche seul - Jean-Jacques Goldman
mkdir "songs\je-marche-seul" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\je-marche-seul/audio.%(ext)s" "ytsearch1:Je marche seul Jean-Jacques Goldman karaoke instrumental"
if exist "songs\je-marche-seul\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [35/100] Là-bas - Jean-Jacques Goldman
mkdir "songs\la-bas" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\la-bas/audio.%(ext)s" "ytsearch1:Là-bas Jean-Jacques Goldman karaoke instrumental"
if exist "songs\la-bas\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [36/100] Il suffira d'un signe - Jean-Jacques Goldman
mkdir "songs\il-suffira" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\il-suffira/audio.%(ext)s" "ytsearch1:Il suffira d'un signe Jean-Jacques Goldman karaoke instrumental"
if exist "songs\il-suffira\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [37/100] Pas là - Jean-Jacques Goldman
mkdir "songs\pas-la" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\pas-la/audio.%(ext)s" "ytsearch1:Pas là Jean-Jacques Goldman karaoke instrumental"
if exist "songs\pas-la\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [38/100] Encore un matin - Jean-Jacques Goldman
mkdir "songs\encore-un-matin" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\encore-un-matin/audio.%(ext)s" "ytsearch1:Encore un matin Jean-Jacques Goldman karaoke instrumental"
if exist "songs\encore-un-matin\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [39/100] Quand la musique est bonne - Jean-Jacques Goldman
mkdir "songs\quand-musique-bonne" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\quand-musique-bonne/audio.%(ext)s" "ytsearch1:Quand la musique est bonne Jean-Jacques Goldman karaoke instrumental"
if exist "songs\quand-musique-bonne\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [40/100] C'est ta chance - Jean-Jacques Goldman
mkdir "songs\cest-ta-chance" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\cest-ta-chance/audio.%(ext)s" "ytsearch1:C'est ta chance Jean-Jacques Goldman karaoke instrumental"
if exist "songs\cest-ta-chance\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [41/100] Mistral gagnant - Renaud
mkdir "songs\mistral-gagnant" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\mistral-gagnant/audio.%(ext)s" "ytsearch1:Mistral gagnant Renaud karaoke instrumental"
if exist "songs\mistral-gagnant\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [42/100] Laisse béton - Renaud
mkdir "songs\laisse-beton" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\laisse-beton/audio.%(ext)s" "ytsearch1:Laisse béton Renaud karaoke instrumental"
if exist "songs\laisse-beton\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [43/100] Dès que le vent soufflera - Renaud
mkdir "songs\des-que-vent" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\des-que-vent/audio.%(ext)s" "ytsearch1:Dès que le vent soufflera Renaud karaoke instrumental"
if exist "songs\des-que-vent\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [44/100] Manhattan-Kaboul - Renaud
mkdir "songs\manhattan-kaboul" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\manhattan-kaboul/audio.%(ext)s" "ytsearch1:Manhattan-Kaboul Renaud karaoke instrumental"
if exist "songs\manhattan-kaboul\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [45/100] Foule sentimentale - Alain Souchon
mkdir "songs\foule-sentimentale" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\foule-sentimentale/audio.%(ext)s" "ytsearch1:Foule sentimentale Alain Souchon karaoke instrumental"
if exist "songs\foule-sentimentale\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [46/100] Allô maman bobo - Alain Souchon
mkdir "songs\allo-maman" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\allo-maman/audio.%(ext)s" "ytsearch1:Allô maman bobo Alain Souchon karaoke instrumental"
if exist "songs\allo-maman\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [47/100] Le téléphone pleure - Alain Souchon
mkdir "songs\telephone-pleure" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\telephone-pleure/audio.%(ext)s" "ytsearch1:Le téléphone pleure Alain Souchon karaoke instrumental"
if exist "songs\telephone-pleure\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [48/100] Rame - Alain Souchon
mkdir "songs\rame" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\rame/audio.%(ext)s" "ytsearch1:Rame Alain Souchon karaoke instrumental"
if exist "songs\rame\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [49/100] Le sud - Nino Ferrer
mkdir "songs\le-sud" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\le-sud/audio.%(ext)s" "ytsearch1:Le sud Nino Ferrer karaoke instrumental"
if exist "songs\le-sud\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [50/100] Mirza - Nino Ferrer
mkdir "songs\mirza" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\mirza/audio.%(ext)s" "ytsearch1:Mirza Nino Ferrer karaoke instrumental"
if exist "songs\mirza\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [51/100] Joe le taxi - Vanessa Paradis
mkdir "songs\joe-taxi" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\joe-taxi/audio.%(ext)s" "ytsearch1:Joe le taxi Vanessa Paradis karaoke instrumental"
if exist "songs\joe-taxi\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [52/100] Marilyn et John - Vanessa Paradis
mkdir "songs\marilyn-john" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\marilyn-john/audio.%(ext)s" "ytsearch1:Marilyn et John Vanessa Paradis karaoke instrumental"
if exist "songs\marilyn-john\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [53/100] Be my baby - Vanessa Paradis
mkdir "songs\be-my-baby" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\be-my-baby/audio.%(ext)s" "ytsearch1:Be my baby Vanessa Paradis karaoke instrumental"
if exist "songs\be-my-baby\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [54/100] On s'attache - Christophe Maé
mkdir "songs\on-sattache" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\on-sattache/audio.%(ext)s" "ytsearch1:On s'attache Christophe Maé karaoke instrumental"
if exist "songs\on-sattache\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [55/100] Belle demoiselle - Christophe Maé
mkdir "songs\belle-demoiselle" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\belle-demoiselle/audio.%(ext)s" "ytsearch1:Belle demoiselle Christophe Maé karaoke instrumental"
if exist "songs\belle-demoiselle\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [56/100] J'ai laissé - Christophe Maé
mkdir "songs\jai-laisse" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\jai-laisse/audio.%(ext)s" "ytsearch1:J'ai laissé Christophe Maé karaoke instrumental"
if exist "songs\jai-laisse\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [57/100] Dingue, dingue, dingue - Christophe Maé
mkdir "songs\dingue" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\dingue/audio.%(ext)s" "ytsearch1:Dingue, dingue, dingue Christophe Maé karaoke instrumental"
if exist "songs\dingue\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [58/100] Papaoutai - Stromae
mkdir "songs\papaoutai" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\papaoutai/audio.%(ext)s" "ytsearch1:Papaoutai Stromae karaoke instrumental"
if exist "songs\papaoutai\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [59/100] Alors on danse - Stromae
mkdir "songs\alors-on-danse" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\alors-on-danse/audio.%(ext)s" "ytsearch1:Alors on danse Stromae karaoke instrumental"
if exist "songs\alors-on-danse\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [60/100] Formidable - Stromae
mkdir "songs\formidable" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\formidable/audio.%(ext)s" "ytsearch1:Formidable Stromae karaoke instrumental"
if exist "songs\formidable\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [61/100] Ta fête - Stromae
mkdir "songs\ta-fete" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\ta-fete/audio.%(ext)s" "ytsearch1:Ta fête Stromae karaoke instrumental"
if exist "songs\ta-fete\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [62/100] Tous les mêmes - Stromae
mkdir "songs\tous-les-memes" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\tous-les-memes/audio.%(ext)s" "ytsearch1:Tous les mêmes Stromae karaoke instrumental"
if exist "songs\tous-les-memes\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [63/100] Dernière danse - Indila
mkdir "songs\derniere-danse" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\derniere-danse/audio.%(ext)s" "ytsearch1:Dernière danse Indila karaoke instrumental"
if exist "songs\derniere-danse\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [64/100] Tourner dans le vide - Indila
mkdir "songs\tourner-vide" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\tourner-vide/audio.%(ext)s" "ytsearch1:Tourner dans le vide Indila karaoke instrumental"
if exist "songs\tourner-vide\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [65/100] Avenir - Louane
mkdir "songs\avenir" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\avenir/audio.%(ext)s" "ytsearch1:Avenir Louane karaoke instrumental"
if exist "songs\avenir\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [66/100] Je veux vivre - Louane
mkdir "songs\je-veux-vivre" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\je-veux-vivre/audio.%(ext)s" "ytsearch1:Je veux vivre Louane karaoke instrumental"
if exist "songs\je-veux-vivre\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [67/100] Je veux - Zaz
mkdir "songs\je-veux" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\je-veux/audio.%(ext)s" "ytsearch1:Je veux Zaz karaoke instrumental"
if exist "songs\je-veux\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [68/100] On ira - Zaz
mkdir "songs\on-ira" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\on-ira/audio.%(ext)s" "ytsearch1:On ira Zaz karaoke instrumental"
if exist "songs\on-ira\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [69/100] Si - Zaz
mkdir "songs\si" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\si/audio.%(ext)s" "ytsearch1:Si Zaz karaoke instrumental"
if exist "songs\si\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [70/100] Éblouie par la nuit - Zaz
mkdir "songs\eblouie-nuit" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\eblouie-nuit/audio.%(ext)s" "ytsearch1:Éblouie par la nuit Zaz karaoke instrumental"
if exist "songs\eblouie-nuit\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [71/100] Balance ton quoi - Angèle
mkdir "songs\balance-ton-quoi" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\balance-ton-quoi/audio.%(ext)s" "ytsearch1:Balance ton quoi Angèle karaoke instrumental"
if exist "songs\balance-ton-quoi\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [72/100] Tout oublier - Angèle
mkdir "songs\tout-oublier" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\tout-oublier/audio.%(ext)s" "ytsearch1:Tout oublier Angèle karaoke instrumental"
if exist "songs\tout-oublier\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [73/100] Fever - Angèle & Dua Lipa
mkdir "songs\fever" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\fever/audio.%(ext)s" "ytsearch1:Fever Angèle & Dua Lipa karaoke instrumental"
if exist "songs\fever\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [74/100] La grenade - Clara Luciani
mkdir "songs\la-grenade" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\la-grenade/audio.%(ext)s" "ytsearch1:La grenade Clara Luciani karaoke instrumental"
if exist "songs\la-grenade\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [75/100] La dernière fois - Clara Luciani
mkdir "songs\la-derniere-fois" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\la-derniere-fois/audio.%(ext)s" "ytsearch1:La dernière fois Clara Luciani karaoke instrumental"
if exist "songs\la-derniere-fois\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [76/100] Respire encore - Clara Luciani
mkdir "songs\respire-encore" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\respire-encore/audio.%(ext)s" "ytsearch1:Respire encore Clara Luciani karaoke instrumental"
if exist "songs\respire-encore\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [77/100] Pas là - Vianney
mkdir "songs\pas-la-vianney" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\pas-la-vianney/audio.%(ext)s" "ytsearch1:Pas là Vianney karaoke instrumental"
if exist "songs\pas-la-vianney\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [78/100] Beau-papa - Vianney
mkdir "songs\beau-papa" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\beau-papa/audio.%(ext)s" "ytsearch1:Beau-papa Vianney karaoke instrumental"
if exist "songs\beau-papa\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [79/100] Le reste - Vianney
mkdir "songs\le-reste" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\le-reste/audio.%(ext)s" "ytsearch1:Le reste Vianney karaoke instrumental"
if exist "songs\le-reste\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [80/100] La vie du bon côté - Keen'V
mkdir "songs\vie-bon-cote" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\vie-bon-cote/audio.%(ext)s" "ytsearch1:La vie du bon côté Keen'V karaoke instrumental"
if exist "songs\vie-bon-cote\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [81/100] J'voulais - Keen'V
mkdir "songs\jvoulais" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\jvoulais/audio.%(ext)s" "ytsearch1:J'voulais Keen'V karaoke instrumental"
if exist "songs\jvoulais\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [82/100] Sapés comme jamais - Maître Gims
mkdir "songs\sapes-comme-jamais" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\sapes-comme-jamais/audio.%(ext)s" "ytsearch1:Sapés comme jamais Maître Gims karaoke instrumental"
if exist "songs\sapes-comme-jamais\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [83/100] Bella - Maître Gims
mkdir "songs\bella" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\bella/audio.%(ext)s" "ytsearch1:Bella Maître Gims karaoke instrumental"
if exist "songs\bella\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [84/100] Est-ce que tu m'aimes - Maître Gims
mkdir "songs\est-ce-que-tu-maimes" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\est-ce-que-tu-maimes/audio.%(ext)s" "ytsearch1:Est-ce que tu m'aimes Maître Gims karaoke instrumental"
if exist "songs\est-ce-que-tu-maimes\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [85/100] Ma philosophie - Amel Bent
mkdir "songs\ma-philosophie" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\ma-philosophie/audio.%(ext)s" "ytsearch1:Ma philosophie Amel Bent karaoke instrumental"
if exist "songs\ma-philosophie\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [86/100] Je veux tout - Amel Bent
mkdir "songs\je-veux-tout" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\je-veux-tout/audio.%(ext)s" "ytsearch1:Je veux tout Amel Bent karaoke instrumental"
if exist "songs\je-veux-tout\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [87/100] L'amour à la plage - Niagara
mkdir "songs\amour-plage" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\amour-plage/audio.%(ext)s" "ytsearch1:L'amour à la plage Niagara karaoke instrumental"
if exist "songs\amour-plage\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [88/100] D.I.S.C.O. - Ottawan
mkdir "songs\disco" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\disco/audio.%(ext)s" "ytsearch1:D.I.S.C.O. Ottawan karaoke instrumental"
if exist "songs\disco\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [89/100] Hands up - Ottawan
mkdir "songs\hands-up" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\hands-up/audio.%(ext)s" "ytsearch1:Hands up Ottawan karaoke instrumental"
if exist "songs\hands-up\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [90/100] Les démons de minuit - Images
mkdir "songs\demons-minuit" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\demons-minuit/audio.%(ext)s" "ytsearch1:Les démons de minuit Images karaoke instrumental"
if exist "songs\demons-minuit\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [91/100] Voyage, voyage - Desireless
mkdir "songs\voyage-voyage" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\voyage-voyage/audio.%(ext)s" "ytsearch1:Voyage, voyage Desireless karaoke instrumental"
if exist "songs\voyage-voyage\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [92/100] Ça plane pour moi - Plastic Bertrand
mkdir "songs\ca-plane" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\ca-plane/audio.%(ext)s" "ytsearch1:Ça plane pour moi Plastic Bertrand karaoke instrumental"
if exist "songs\ca-plane\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [93/100] Les sunlights des tropiques - Gilbert Montagné
mkdir "songs\sunlights-tropiques" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\sunlights-tropiques/audio.%(ext)s" "ytsearch1:Les sunlights des tropiques Gilbert Montagné karaoke instrumental"
if exist "songs\sunlights-tropiques\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [94/100] On va s'aimer - Gilbert Montagné
mkdir "songs\on-va-saimer" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\on-va-saimer/audio.%(ext)s" "ytsearch1:On va s'aimer Gilbert Montagné karaoke instrumental"
if exist "songs\on-va-saimer\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [95/100] Mademoiselle chante le blues - Patricia Kaas
mkdir "songs\mademoiselle-blues" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\mademoiselle-blues/audio.%(ext)s" "ytsearch1:Mademoiselle chante le blues Patricia Kaas karaoke instrumental"
if exist "songs\mademoiselle-blues\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [96/100] Le chanteur - Daniel Balavoine
mkdir "songs\le-chanteur" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\le-chanteur/audio.%(ext)s" "ytsearch1:Le chanteur Daniel Balavoine karaoke instrumental"
if exist "songs\le-chanteur\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [97/100] L'Aziza - Daniel Balavoine
mkdir "songs\laziza" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\laziza/audio.%(ext)s" "ytsearch1:L'Aziza Daniel Balavoine karaoke instrumental"
if exist "songs\laziza\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [98/100] Sauver l'amour - Daniel Balavoine
mkdir "songs\sauver-amour" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\sauver-amour/audio.%(ext)s" "ytsearch1:Sauver l'amour Daniel Balavoine karaoke instrumental"
if exist "songs\sauver-amour\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [99/100] L'encre de tes yeux - Francis Cabrel
mkdir "songs\encre-yeux" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\encre-yeux/audio.%(ext)s" "ytsearch1:L'encre de tes yeux Francis Cabrel karaoke instrumental"
if exist "songs\encre-yeux\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo [100/100] Je l'aime à mourir - Francis Cabrel
mkdir "songs\je-taime-a-mourir" 2>nul
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs\je-taime-a-mourir/audio.%(ext)s" "ytsearch1:Je l'aime à mourir Francis Cabrel karaoke instrumental"
if exist "songs\je-taime-a-mourir\audio.mp3" (
  echo   [OK] Telecharge
) else (
  echo   [ECHEC] Non trouve - cherche manuellement
)

echo.
echo =========================================
echo  TELECHARGEMENT TERMINE
echo =========================================
echo.
pause