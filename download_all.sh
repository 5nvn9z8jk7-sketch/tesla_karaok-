#!/bin/bash
# Téléchargement des instrumentaux karaoké
# Usage: ./download_all.sh

cd "$(dirname "$0")"

echo "========================================="
echo " TELECHARGEMENT DES INSTRUMENTAUX KARAOKE"
echo "========================================="

echo "[1/100] La Vie en Rose - Édith Piaf"
mkdir -p "songs/vie-en-rose"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/vie-en-rose/audio.%(ext)s" "ytsearch1:La Vie en Rose Édith Piaf karaoke instrumental"
if [ -f "songs/vie-en-rose/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[2/100] Non, je ne regrette rien - Édith Piaf"
mkdir -p "songs/ne-regrette-rien"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/ne-regrette-rien/audio.%(ext)s" "ytsearch1:Non, je ne regrette rien Édith Piaf karaoke instrumental"
if [ -f "songs/ne-regrette-rien/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[3/100] Sous le ciel de Paris - Édith Piaf"
mkdir -p "songs/sous-ciel-paris"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/sous-ciel-paris/audio.%(ext)s" "ytsearch1:Sous le ciel de Paris Édith Piaf karaoke instrumental"
if [ -f "songs/sous-ciel-paris/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[4/100] Milord - Édith Piaf"
mkdir -p "songs/milord"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/milord/audio.%(ext)s" "ytsearch1:Milord Édith Piaf karaoke instrumental"
if [ -f "songs/milord/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[5/100] L'hymne à l'amour - Édith Piaf"
mkdir -p "songs/hymne-amour"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/hymne-amour/audio.%(ext)s" "ytsearch1:L'hymne à l'amour Édith Piaf karaoke instrumental"
if [ -f "songs/hymne-amour/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[6/100] La Bohème - Charles Aznavour"
mkdir -p "songs/boheme"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/boheme/audio.%(ext)s" "ytsearch1:La Bohème Charles Aznavour karaoke instrumental"
if [ -f "songs/boheme/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[7/100] Emmenez-moi - Charles Aznavour"
mkdir -p "songs/emmenez-moi"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/emmenez-moi/audio.%(ext)s" "ytsearch1:Emmenez-moi Charles Aznavour karaoke instrumental"
if [ -f "songs/emmenez-moi/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[8/100] Hier encore - Charles Aznavour"
mkdir -p "songs/hier-encore"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/hier-encore/audio.%(ext)s" "ytsearch1:Hier encore Charles Aznavour karaoke instrumental"
if [ -f "songs/hier-encore/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[9/100] La Mamma - Charles Aznavour"
mkdir -p "songs/la-mamma"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/la-mamma/audio.%(ext)s" "ytsearch1:La Mamma Charles Aznavour karaoke instrumental"
if [ -f "songs/la-mamma/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[10/100] She - Charles Aznavour"
mkdir -p "songs/she"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/she/audio.%(ext)s" "ytsearch1:She Charles Aznavour karaoke instrumental"
if [ -f "songs/she/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[11/100] L'été indien - Joe Dassin"
mkdir -p "songs/ete-indien"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/ete-indien/audio.%(ext)s" "ytsearch1:L'été indien Joe Dassin karaoke instrumental"
if [ -f "songs/ete-indien/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[12/100] Les Champs-Élysées - Joe Dassin"
mkdir -p "songs/champs-elysees"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/champs-elysees/audio.%(ext)s" "ytsearch1:Les Champs-Élysées Joe Dassin karaoke instrumental"
if [ -f "songs/champs-elysees/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[13/100] Salut les amoureux - Joe Dassin"
mkdir -p "songs/salut-amoureux"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/salut-amoureux/audio.%(ext)s" "ytsearch1:Salut les amoureux Joe Dassin karaoke instrumental"
if [ -f "songs/salut-amoureux/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[14/100] Le petit pain au chocolat - Joe Dassin"
mkdir -p "songs/petit-pain"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/petit-pain/audio.%(ext)s" "ytsearch1:Le petit pain au chocolat Joe Dassin karaoke instrumental"
if [ -f "songs/petit-pain/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[15/100] Siffler sur la colline - Joe Dassin"
mkdir -p "songs/siffler-colline"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/siffler-colline/audio.%(ext)s" "ytsearch1:Siffler sur la colline Joe Dassin karaoke instrumental"
if [ -f "songs/siffler-colline/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[16/100] Les feuilles mortes - Yves Montand"
mkdir -p "songs/feuilles-mortes"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/feuilles-mortes/audio.%(ext)s" "ytsearch1:Les feuilles mortes Yves Montand karaoke instrumental"
if [ -f "songs/feuilles-mortes/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[17/100] C'est si bon - Yves Montand"
mkdir -p "songs/cest-si-bon"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/cest-si-bon/audio.%(ext)s" "ytsearch1:C'est si bon Yves Montand karaoke instrumental"
if [ -f "songs/cest-si-bon/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[18/100] La mer - Charles Trenet"
mkdir -p "songs/la-mer"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/la-mer/audio.%(ext)s" "ytsearch1:La mer Charles Trenet karaoke instrumental"
if [ -f "songs/la-mer/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[19/100] Douce France - Charles Trenet"
mkdir -p "songs/douce-france"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/douce-france/audio.%(ext)s" "ytsearch1:Douce France Charles Trenet karaoke instrumental"
if [ -f "songs/douce-france/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[20/100] Boum ! - Charles Trenet"
mkdir -p "songs/boum"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/boum/audio.%(ext)s" "ytsearch1:Boum ! Charles Trenet karaoke instrumental"
if [ -f "songs/boum/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[21/100] Poupée de cire, poupée de son - France Gall"
mkdir -p "songs/poupee-cire"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/poupee-cire/audio.%(ext)s" "ytsearch1:Poupée de cire, poupée de son France Gall karaoke instrumental"
if [ -f "songs/poupee-cire/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[22/100] Ella, elle l'a - France Gall"
mkdir -p "songs/ella-elle-la"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/ella-elle-la/audio.%(ext)s" "ytsearch1:Ella, elle l'a France Gall karaoke instrumental"
if [ -f "songs/ella-elle-la/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[23/100] Babacar - France Gall"
mkdir -p "songs/babacar"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/babacar/audio.%(ext)s" "ytsearch1:Babacar France Gall karaoke instrumental"
if [ -f "songs/babacar/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[24/100] Diego, libre dans sa tête - France Gall"
mkdir -p "songs/diego"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/diego/audio.%(ext)s" "ytsearch1:Diego, libre dans sa tête France Gall karaoke instrumental"
if [ -f "songs/diego/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[25/100] La groupie du pianiste - Michel Berger"
mkdir -p "songs/groupie-pianiste"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/groupie-pianiste/audio.%(ext)s" "ytsearch1:La groupie du pianiste Michel Berger karaoke instrumental"
if [ -f "songs/groupie-pianiste/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[26/100] Quelques mots d'amour - Michel Berger"
mkdir -p "songs/quelques-mots"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/quelques-mots/audio.%(ext)s" "ytsearch1:Quelques mots d'amour Michel Berger karaoke instrumental"
if [ -f "songs/quelques-mots/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[27/100] Un peu de blues - Michel Berger"
mkdir -p "songs/peu-de-blues"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/peu-de-blues/audio.%(ext)s" "ytsearch1:Un peu de blues Michel Berger karaoke instrumental"
if [ -f "songs/peu-de-blues/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[28/100] Les lacs du Connemara - Michel Sardou"
mkdir -p "songs/lacs-connemara"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/lacs-connemara/audio.%(ext)s" "ytsearch1:Les lacs du Connemara Michel Sardou karaoke instrumental"
if [ -f "songs/lacs-connemara/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[29/100] Je vais t'aimer - Michel Sardou"
mkdir -p "songs/je-vais-t-aimer"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/je-vais-t-aimer/audio.%(ext)s" "ytsearch1:Je vais t'aimer Michel Sardou karaoke instrumental"
if [ -f "songs/je-vais-t-aimer/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[30/100] Être une femme - Michel Sardou"
mkdir -p "songs/etre-une-femme"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/etre-une-femme/audio.%(ext)s" "ytsearch1:Être une femme Michel Sardou karaoke instrumental"
if [ -f "songs/etre-une-femme/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[31/100] Les villes de solitude - Michel Sardou"
mkdir -p "songs/villes-solitude"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/villes-solitude/audio.%(ext)s" "ytsearch1:Les villes de solitude Michel Sardou karaoke instrumental"
if [ -f "songs/villes-solitude/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[32/100] La maladie d'amour - Michel Sardou"
mkdir -p "songs/maladie-amour"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/maladie-amour/audio.%(ext)s" "ytsearch1:La maladie d'amour Michel Sardou karaoke instrumental"
if [ -f "songs/maladie-amour/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[33/100] Envole-moi - Jean-Jacques Goldman"
mkdir -p "songs/envole-moi"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/envole-moi/audio.%(ext)s" "ytsearch1:Envole-moi Jean-Jacques Goldman karaoke instrumental"
if [ -f "songs/envole-moi/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[34/100] Je marche seul - Jean-Jacques Goldman"
mkdir -p "songs/je-marche-seul"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/je-marche-seul/audio.%(ext)s" "ytsearch1:Je marche seul Jean-Jacques Goldman karaoke instrumental"
if [ -f "songs/je-marche-seul/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[35/100] Là-bas - Jean-Jacques Goldman"
mkdir -p "songs/la-bas"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/la-bas/audio.%(ext)s" "ytsearch1:Là-bas Jean-Jacques Goldman karaoke instrumental"
if [ -f "songs/la-bas/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[36/100] Il suffira d'un signe - Jean-Jacques Goldman"
mkdir -p "songs/il-suffira"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/il-suffira/audio.%(ext)s" "ytsearch1:Il suffira d'un signe Jean-Jacques Goldman karaoke instrumental"
if [ -f "songs/il-suffira/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[37/100] Pas là - Jean-Jacques Goldman"
mkdir -p "songs/pas-la"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/pas-la/audio.%(ext)s" "ytsearch1:Pas là Jean-Jacques Goldman karaoke instrumental"
if [ -f "songs/pas-la/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[38/100] Encore un matin - Jean-Jacques Goldman"
mkdir -p "songs/encore-un-matin"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/encore-un-matin/audio.%(ext)s" "ytsearch1:Encore un matin Jean-Jacques Goldman karaoke instrumental"
if [ -f "songs/encore-un-matin/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[39/100] Quand la musique est bonne - Jean-Jacques Goldman"
mkdir -p "songs/quand-musique-bonne"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/quand-musique-bonne/audio.%(ext)s" "ytsearch1:Quand la musique est bonne Jean-Jacques Goldman karaoke instrumental"
if [ -f "songs/quand-musique-bonne/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[40/100] C'est ta chance - Jean-Jacques Goldman"
mkdir -p "songs/cest-ta-chance"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/cest-ta-chance/audio.%(ext)s" "ytsearch1:C'est ta chance Jean-Jacques Goldman karaoke instrumental"
if [ -f "songs/cest-ta-chance/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[41/100] Mistral gagnant - Renaud"
mkdir -p "songs/mistral-gagnant"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/mistral-gagnant/audio.%(ext)s" "ytsearch1:Mistral gagnant Renaud karaoke instrumental"
if [ -f "songs/mistral-gagnant/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[42/100] Laisse béton - Renaud"
mkdir -p "songs/laisse-beton"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/laisse-beton/audio.%(ext)s" "ytsearch1:Laisse béton Renaud karaoke instrumental"
if [ -f "songs/laisse-beton/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[43/100] Dès que le vent soufflera - Renaud"
mkdir -p "songs/des-que-vent"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/des-que-vent/audio.%(ext)s" "ytsearch1:Dès que le vent soufflera Renaud karaoke instrumental"
if [ -f "songs/des-que-vent/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[44/100] Manhattan-Kaboul - Renaud"
mkdir -p "songs/manhattan-kaboul"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/manhattan-kaboul/audio.%(ext)s" "ytsearch1:Manhattan-Kaboul Renaud karaoke instrumental"
if [ -f "songs/manhattan-kaboul/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[45/100] Foule sentimentale - Alain Souchon"
mkdir -p "songs/foule-sentimentale"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/foule-sentimentale/audio.%(ext)s" "ytsearch1:Foule sentimentale Alain Souchon karaoke instrumental"
if [ -f "songs/foule-sentimentale/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[46/100] Allô maman bobo - Alain Souchon"
mkdir -p "songs/allo-maman"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/allo-maman/audio.%(ext)s" "ytsearch1:Allô maman bobo Alain Souchon karaoke instrumental"
if [ -f "songs/allo-maman/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[47/100] Le téléphone pleure - Alain Souchon"
mkdir -p "songs/telephone-pleure"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/telephone-pleure/audio.%(ext)s" "ytsearch1:Le téléphone pleure Alain Souchon karaoke instrumental"
if [ -f "songs/telephone-pleure/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[48/100] Rame - Alain Souchon"
mkdir -p "songs/rame"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/rame/audio.%(ext)s" "ytsearch1:Rame Alain Souchon karaoke instrumental"
if [ -f "songs/rame/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[49/100] Le sud - Nino Ferrer"
mkdir -p "songs/le-sud"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/le-sud/audio.%(ext)s" "ytsearch1:Le sud Nino Ferrer karaoke instrumental"
if [ -f "songs/le-sud/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[50/100] Mirza - Nino Ferrer"
mkdir -p "songs/mirza"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/mirza/audio.%(ext)s" "ytsearch1:Mirza Nino Ferrer karaoke instrumental"
if [ -f "songs/mirza/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[51/100] Joe le taxi - Vanessa Paradis"
mkdir -p "songs/joe-taxi"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/joe-taxi/audio.%(ext)s" "ytsearch1:Joe le taxi Vanessa Paradis karaoke instrumental"
if [ -f "songs/joe-taxi/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[52/100] Marilyn et John - Vanessa Paradis"
mkdir -p "songs/marilyn-john"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/marilyn-john/audio.%(ext)s" "ytsearch1:Marilyn et John Vanessa Paradis karaoke instrumental"
if [ -f "songs/marilyn-john/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[53/100] Be my baby - Vanessa Paradis"
mkdir -p "songs/be-my-baby"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/be-my-baby/audio.%(ext)s" "ytsearch1:Be my baby Vanessa Paradis karaoke instrumental"
if [ -f "songs/be-my-baby/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[54/100] On s'attache - Christophe Maé"
mkdir -p "songs/on-sattache"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/on-sattache/audio.%(ext)s" "ytsearch1:On s'attache Christophe Maé karaoke instrumental"
if [ -f "songs/on-sattache/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[55/100] Belle demoiselle - Christophe Maé"
mkdir -p "songs/belle-demoiselle"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/belle-demoiselle/audio.%(ext)s" "ytsearch1:Belle demoiselle Christophe Maé karaoke instrumental"
if [ -f "songs/belle-demoiselle/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[56/100] J'ai laissé - Christophe Maé"
mkdir -p "songs/jai-laisse"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/jai-laisse/audio.%(ext)s" "ytsearch1:J'ai laissé Christophe Maé karaoke instrumental"
if [ -f "songs/jai-laisse/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[57/100] Dingue, dingue, dingue - Christophe Maé"
mkdir -p "songs/dingue"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/dingue/audio.%(ext)s" "ytsearch1:Dingue, dingue, dingue Christophe Maé karaoke instrumental"
if [ -f "songs/dingue/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[58/100] Papaoutai - Stromae"
mkdir -p "songs/papaoutai"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/papaoutai/audio.%(ext)s" "ytsearch1:Papaoutai Stromae karaoke instrumental"
if [ -f "songs/papaoutai/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[59/100] Alors on danse - Stromae"
mkdir -p "songs/alors-on-danse"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/alors-on-danse/audio.%(ext)s" "ytsearch1:Alors on danse Stromae karaoke instrumental"
if [ -f "songs/alors-on-danse/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[60/100] Formidable - Stromae"
mkdir -p "songs/formidable"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/formidable/audio.%(ext)s" "ytsearch1:Formidable Stromae karaoke instrumental"
if [ -f "songs/formidable/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[61/100] Ta fête - Stromae"
mkdir -p "songs/ta-fete"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/ta-fete/audio.%(ext)s" "ytsearch1:Ta fête Stromae karaoke instrumental"
if [ -f "songs/ta-fete/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[62/100] Tous les mêmes - Stromae"
mkdir -p "songs/tous-les-memes"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/tous-les-memes/audio.%(ext)s" "ytsearch1:Tous les mêmes Stromae karaoke instrumental"
if [ -f "songs/tous-les-memes/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[63/100] Dernière danse - Indila"
mkdir -p "songs/derniere-danse"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/derniere-danse/audio.%(ext)s" "ytsearch1:Dernière danse Indila karaoke instrumental"
if [ -f "songs/derniere-danse/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[64/100] Tourner dans le vide - Indila"
mkdir -p "songs/tourner-vide"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/tourner-vide/audio.%(ext)s" "ytsearch1:Tourner dans le vide Indila karaoke instrumental"
if [ -f "songs/tourner-vide/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[65/100] Avenir - Louane"
mkdir -p "songs/avenir"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/avenir/audio.%(ext)s" "ytsearch1:Avenir Louane karaoke instrumental"
if [ -f "songs/avenir/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[66/100] Je veux vivre - Louane"
mkdir -p "songs/je-veux-vivre"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/je-veux-vivre/audio.%(ext)s" "ytsearch1:Je veux vivre Louane karaoke instrumental"
if [ -f "songs/je-veux-vivre/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[67/100] Je veux - Zaz"
mkdir -p "songs/je-veux"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/je-veux/audio.%(ext)s" "ytsearch1:Je veux Zaz karaoke instrumental"
if [ -f "songs/je-veux/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[68/100] On ira - Zaz"
mkdir -p "songs/on-ira"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/on-ira/audio.%(ext)s" "ytsearch1:On ira Zaz karaoke instrumental"
if [ -f "songs/on-ira/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[69/100] Si - Zaz"
mkdir -p "songs/si"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/si/audio.%(ext)s" "ytsearch1:Si Zaz karaoke instrumental"
if [ -f "songs/si/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[70/100] Éblouie par la nuit - Zaz"
mkdir -p "songs/eblouie-nuit"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/eblouie-nuit/audio.%(ext)s" "ytsearch1:Éblouie par la nuit Zaz karaoke instrumental"
if [ -f "songs/eblouie-nuit/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[71/100] Balance ton quoi - Angèle"
mkdir -p "songs/balance-ton-quoi"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/balance-ton-quoi/audio.%(ext)s" "ytsearch1:Balance ton quoi Angèle karaoke instrumental"
if [ -f "songs/balance-ton-quoi/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[72/100] Tout oublier - Angèle"
mkdir -p "songs/tout-oublier"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/tout-oublier/audio.%(ext)s" "ytsearch1:Tout oublier Angèle karaoke instrumental"
if [ -f "songs/tout-oublier/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[73/100] Fever - Angèle & Dua Lipa"
mkdir -p "songs/fever"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/fever/audio.%(ext)s" "ytsearch1:Fever Angèle & Dua Lipa karaoke instrumental"
if [ -f "songs/fever/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[74/100] La grenade - Clara Luciani"
mkdir -p "songs/la-grenade"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/la-grenade/audio.%(ext)s" "ytsearch1:La grenade Clara Luciani karaoke instrumental"
if [ -f "songs/la-grenade/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[75/100] La dernière fois - Clara Luciani"
mkdir -p "songs/la-derniere-fois"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/la-derniere-fois/audio.%(ext)s" "ytsearch1:La dernière fois Clara Luciani karaoke instrumental"
if [ -f "songs/la-derniere-fois/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[76/100] Respire encore - Clara Luciani"
mkdir -p "songs/respire-encore"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/respire-encore/audio.%(ext)s" "ytsearch1:Respire encore Clara Luciani karaoke instrumental"
if [ -f "songs/respire-encore/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[77/100] Pas là - Vianney"
mkdir -p "songs/pas-la-vianney"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/pas-la-vianney/audio.%(ext)s" "ytsearch1:Pas là Vianney karaoke instrumental"
if [ -f "songs/pas-la-vianney/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[78/100] Beau-papa - Vianney"
mkdir -p "songs/beau-papa"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/beau-papa/audio.%(ext)s" "ytsearch1:Beau-papa Vianney karaoke instrumental"
if [ -f "songs/beau-papa/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[79/100] Le reste - Vianney"
mkdir -p "songs/le-reste"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/le-reste/audio.%(ext)s" "ytsearch1:Le reste Vianney karaoke instrumental"
if [ -f "songs/le-reste/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[80/100] La vie du bon côté - Keen'V"
mkdir -p "songs/vie-bon-cote"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/vie-bon-cote/audio.%(ext)s" "ytsearch1:La vie du bon côté Keen'V karaoke instrumental"
if [ -f "songs/vie-bon-cote/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[81/100] J'voulais - Keen'V"
mkdir -p "songs/jvoulais"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/jvoulais/audio.%(ext)s" "ytsearch1:J'voulais Keen'V karaoke instrumental"
if [ -f "songs/jvoulais/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[82/100] Sapés comme jamais - Maître Gims"
mkdir -p "songs/sapes-comme-jamais"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/sapes-comme-jamais/audio.%(ext)s" "ytsearch1:Sapés comme jamais Maître Gims karaoke instrumental"
if [ -f "songs/sapes-comme-jamais/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[83/100] Bella - Maître Gims"
mkdir -p "songs/bella"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/bella/audio.%(ext)s" "ytsearch1:Bella Maître Gims karaoke instrumental"
if [ -f "songs/bella/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[84/100] Est-ce que tu m'aimes - Maître Gims"
mkdir -p "songs/est-ce-que-tu-maimes"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/est-ce-que-tu-maimes/audio.%(ext)s" "ytsearch1:Est-ce que tu m'aimes Maître Gims karaoke instrumental"
if [ -f "songs/est-ce-que-tu-maimes/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[85/100] Ma philosophie - Amel Bent"
mkdir -p "songs/ma-philosophie"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/ma-philosophie/audio.%(ext)s" "ytsearch1:Ma philosophie Amel Bent karaoke instrumental"
if [ -f "songs/ma-philosophie/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[86/100] Je veux tout - Amel Bent"
mkdir -p "songs/je-veux-tout"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/je-veux-tout/audio.%(ext)s" "ytsearch1:Je veux tout Amel Bent karaoke instrumental"
if [ -f "songs/je-veux-tout/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[87/100] L'amour à la plage - Niagara"
mkdir -p "songs/amour-plage"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/amour-plage/audio.%(ext)s" "ytsearch1:L'amour à la plage Niagara karaoke instrumental"
if [ -f "songs/amour-plage/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[88/100] D.I.S.C.O. - Ottawan"
mkdir -p "songs/disco"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/disco/audio.%(ext)s" "ytsearch1:D.I.S.C.O. Ottawan karaoke instrumental"
if [ -f "songs/disco/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[89/100] Hands up - Ottawan"
mkdir -p "songs/hands-up"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/hands-up/audio.%(ext)s" "ytsearch1:Hands up Ottawan karaoke instrumental"
if [ -f "songs/hands-up/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[90/100] Les démons de minuit - Images"
mkdir -p "songs/demons-minuit"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/demons-minuit/audio.%(ext)s" "ytsearch1:Les démons de minuit Images karaoke instrumental"
if [ -f "songs/demons-minuit/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[91/100] Voyage, voyage - Desireless"
mkdir -p "songs/voyage-voyage"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/voyage-voyage/audio.%(ext)s" "ytsearch1:Voyage, voyage Desireless karaoke instrumental"
if [ -f "songs/voyage-voyage/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[92/100] Ça plane pour moi - Plastic Bertrand"
mkdir -p "songs/ca-plane"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/ca-plane/audio.%(ext)s" "ytsearch1:Ça plane pour moi Plastic Bertrand karaoke instrumental"
if [ -f "songs/ca-plane/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[93/100] Les sunlights des tropiques - Gilbert Montagné"
mkdir -p "songs/sunlights-tropiques"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/sunlights-tropiques/audio.%(ext)s" "ytsearch1:Les sunlights des tropiques Gilbert Montagné karaoke instrumental"
if [ -f "songs/sunlights-tropiques/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[94/100] On va s'aimer - Gilbert Montagné"
mkdir -p "songs/on-va-saimer"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/on-va-saimer/audio.%(ext)s" "ytsearch1:On va s'aimer Gilbert Montagné karaoke instrumental"
if [ -f "songs/on-va-saimer/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[95/100] Mademoiselle chante le blues - Patricia Kaas"
mkdir -p "songs/mademoiselle-blues"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/mademoiselle-blues/audio.%(ext)s" "ytsearch1:Mademoiselle chante le blues Patricia Kaas karaoke instrumental"
if [ -f "songs/mademoiselle-blues/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[96/100] Le chanteur - Daniel Balavoine"
mkdir -p "songs/le-chanteur"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/le-chanteur/audio.%(ext)s" "ytsearch1:Le chanteur Daniel Balavoine karaoke instrumental"
if [ -f "songs/le-chanteur/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[97/100] L'Aziza - Daniel Balavoine"
mkdir -p "songs/laziza"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/laziza/audio.%(ext)s" "ytsearch1:L'Aziza Daniel Balavoine karaoke instrumental"
if [ -f "songs/laziza/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[98/100] Sauver l'amour - Daniel Balavoine"
mkdir -p "songs/sauver-amour"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/sauver-amour/audio.%(ext)s" "ytsearch1:Sauver l'amour Daniel Balavoine karaoke instrumental"
if [ -f "songs/sauver-amour/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[99/100] L'encre de tes yeux - Francis Cabrel"
mkdir -p "songs/encre-yeux"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/encre-yeux/audio.%(ext)s" "ytsearch1:L'encre de tes yeux Francis Cabrel karaoke instrumental"
if [ -f "songs/encre-yeux/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "[100/100] Je l'aime à mourir - Francis Cabrel"
mkdir -p "songs/je-taime-a-mourir"
yt-dlp -x --audio-format mp3 --audio-quality 0 --no-playlist -o "songs/je-taime-a-mourir/audio.%(ext)s" "ytsearch1:Je l'aime à mourir Francis Cabrel karaoke instrumental"
if [ -f "songs/je-taime-a-mourir/audio.mp3" ]; then echo "  [OK]"; else echo "  [ECHEC]"; fi

echo "Termine!"