#!/usr/bin/env python3
import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
# -*- coding: utf-8 -*-
"""
Générateur de 100 chansons françaises pour Tesla Karaoké Party
Crée les dossiers, fichiers LRC (paroles synchronisées) et met à jour le manifest
"""

import os
import json
import wave
import struct
import math
import random

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
SONGS_DIR = os.path.join(BASE_DIR, 'songs')

# ============================================================
# LISTE DES 100 CHANSONS FRANÇAISES
# Format: (id, titre, artiste, difficulté, genre, paroles)
# paroles = liste de (timestamp_secondes, texte)
# ============================================================

CHANSONS = [
    # --- ÉDITH PIAF (5) ---
    ("vie-en-rose", "La Vie en Rose", "Édith Piaf", "medium", "variete", [
        (2.0, "Quand il me prend dans ses bras"),
        (5.5, "Il me parle tout bas"),
        (9.0, "Je vois la vie en rose"),
        (13.0, "Il me dit des mots d'amour"),
        (16.5, "Des mots de tous les jours"),
        (20.0, "Et ça me fait quelque chose"),
        (24.0, "Il est entré dans mon cœur"),
        (27.5, "Une part de bonheur"),
        (31.0, "Dont je connais la cause"),
        (35.0, "C'est toi pour toujours"),
        (38.5, "Toi qui m'as donné"),
        (42.0, "Des rêves d'amour"),
        (46.0, "Des rêves qui durent"),
        (50.0, "Quand il me prend dans ses bras"),
        (53.5, "Je vois la vie en rose"),
    ]),
    ("ne-regrette-rien", "Non, je ne regrette rien", "Édith Piaf", "medium", "variete", [
        (2.0, "Non, rien de rien"),
        (5.0, "Non, je ne regrette rien"),
        (9.0, "Ni le bien qu'on m'a fait"),
        (12.5, "Ni le mal"),
        (15.5, "Tout ça m'est bien égal"),
        (19.5, "Non, rien de rien"),
        (22.5, "Non, je ne regrette rien"),
        (26.0, "C'est payé,扫é, oublié"),
        (30.0, "Je me fous du passé"),
        (34.0, "Avec mes souvenirs"),
        (37.5, "J'ai allumé le feu"),
        (41.0, "Mes chagrins, mes plaisirs"),
        (44.5, "Je n'ai plus besoin d'eux"),
        (48.5, "Balayés pour toujours"),
        (52.0, "Je repars à zéro"),
        (56.0, "Non, rien de rien"),
        (59.0, "Non, je ne regrette rien"),
    ]),
    ("sous-ciel-paris", "Sous le ciel de Paris", "Édith Piaf", "medium", "variete", [
        (2.0, "Sous le ciel de Paris"),
        (6.0, "S'envole une chanson"),
        (10.0, "Elle est née d'aujourd'hui"),
        (14.0, "Dans le cœur d'un garçon"),
        (18.0, "Sous le ciel de Paris"),
        (22.0, "Quand elle lui sourit"),
        (26.0, "Il y a du soleil sur son visage"),
        (31.0, "Près de la Seine"),
        (35.0, "Sous le ciel de Paris"),
        (39.0, "Je ne quitterais pas la ville"),
        (44.0, "Sans entendre sa chanson"),
        (48.5, "Elle est à moi"),
        (52.5, "Des nuits d'amour"),
    ]),
    ("milord", "Milord", "Édith Piaf", "easy", "variete", [
        (2.0, "Allez, venez, Milord"),
        (5.5, "Vous asseoir à ma table"),
        (9.0, "Il fait si froid dehors"),
        (12.5, "Ici c'est la place"),
        (16.0, "Laissez-moi"),
        (19.0, "Vousmettre à l'abri"),
        (22.5, "Dans mon cœur"),
        (26.0, "Allez, venez, Milord"),
        (29.5, "Je vous en prie"),
        (33.0, "Asseyez-vous"),
        (36.5, "Je vous en supplie"),
        (40.0, "Ne partez pas"),
        (43.5, "Avant d'avoir bu"),
        (47.0, "Quelque chose"),
    ]),
    ("hymne-amour", "L'hymne à l'amour", "Édith Piaf", "hard", "variete", [
        (2.0, "Le ciel bleu sur nous peut s'effondrer"),
        (7.0, "Et la terre peut bien s'écrouler"),
        (12.0, "Peu m'importe si tu m'aimes"),
        (16.0, "Je me fous du monde entier"),
        (21.0, "Tant que l'amour inond' mes matins"),
        (26.0, "Tant que l'amour fera battre mon cœur"),
        (31.0, "Peu m'importe les ennuis"),
        (35.0, "Peu m'importe le froid, peu m'importe le jour"),
        (41.0, "Je suis capable"),
        (44.5, "De n'importe quoi"),
        (48.0, "Si tu me le demandes"),
        (52.5, "Une étoile"),
        (56.0, "Qui vient de si haut"),
    ]),

    # --- CHARLES AZNAVOUR (5) ---
    ("boheme", "La Bohème", "Charles Aznavour", "medium", "variete", [
        (2.0, "Je vous parle d'un temps"),
        (6.0, "Que les moins de vingt ans"),
        (10.0, "Ne peuvent pas connaître"),
        (14.0, "Montmartre en ce temps-là"),
        (18.0, "Accrochait ses lilas"),
        (22.0, " jusque sous les fenêtres"),
        (27.0, "Et si la vie ne m'avait"),
        (32.0, "Donné que pour chanter"),
        (36.5, "Je ne serais qu'un légende"),
        (42.0, "Je vous parle d'un temps"),
        (46.0, "Où Montmartre s'appelait la Butte"),
        (51.0, "Et qu'aujourd'hui"),
        (55.0, "Le Sacré-Cœur domine la ville"),
    ]),
    ("emmenez-moi", "Emmenez-moi", "Charles Aznavour", "medium", "variete", [
        (2.0, "Vers les ciliques éternelles"),
        (6.5, "Où l'on rit à ne plus mourir"),
        (11.0, "Emmenez-moi"),
        (14.0, "Vers lesrivages de lumière"),
        (18.5, "Où les amants séculaires"),
        (23.0, "Font la fête sur la mer"),
        (27.5, "Emmenez-moi"),
        (31.0, "Vers les pays du soleil"),
        (35.5, "Où les femmes sont reines"),
        (40.0, "Emmenez-moi"),
        (43.5, "Vers lescieux de cristal"),
        (48.0, "Où tout est éternel"),
    ]),
    ("hier-encore", "Hier encore", "Charles Aznavour", "easy", "variete", [
        (2.0, "Hier encore, j'avais vingt ans"),
        (6.0, "Je caressais le temps"),
        (9.5, "Et jouais de la vie"),
        (13.0, "Comme on aime une maîtresse"),
        (17.0, "Sans szám soucier du lendemain"),
        (21.0, "Je faisais des projets"),
        (24.5, "Qui ne duraient qu'un jour"),
        (28.0, "Mais ce temps emporte trop de rêves"),
        (33.0, "Qui se dissipent aux lendemains"),
        (38.0, "Et tu sais, l'enfant"),
        (42.0, "Hier encore, j'avais vingt ans"),
    ]),
    ("la-mamma", "La Mamma", "Charles Aznavour", "medium", "variete", [
        (2.0, "C'est elle que le destin"),
        (6.0, "M'a fait rencontrer"),
        (9.5, "Avant que de mourir"),
        (13.0, "Dans un dernier sursaut"),
        (17.0, "Elle a tendu la main"),
        (20.5, "Vers moi, pauvre de moi"),
        (24.0, "Qui n'avais plus personne"),
        (28.0, "Sur cette terre"),
        (32.0, "Sans elle, je ne suis rien"),
        (36.0, "Plus rien qu'une ombre"),
        (40.0, "La mamma, la mamma"),
        (44.0, "C'est la plus belle"),
        (48.0, "Des mamans"),
    ]),
    ("she", "She", "Charles Aznavour", "medium", "variete", [
        (2.0, "She, tous les matins"),
        (6.0, "Elle se lève"),
        (9.0, "Avant que le jour ne vienne"),
        (13.0, "Elle s'habille"),
        (16.0, "De sa robe de chambre"),
        (20.0, "Elle descend l'escalier"),
        (24.0, "Sans bruit, sans faire de bruit"),
        (28.5, "She, elle est si jolie"),
        (32.5, "Quand elle sourit"),
        (36.0, "Moi, je suis là"),
        (40.0, "Je la regarde"),
        (44.0, "She, elle est ma vie"),
    ]),

    # --- JOE DASSIN (5) ---
    ("ete-indien", "L'été indien", "Joe Dassin", "easy", "variete", [
        (2.0, "Un indien dans la baie"),
        (5.5, "Un Glaswegian au pays du matador"),
        (10.0, "Je revois tes lacs, tes cascades"),
        (14.5, "Et dans ta beauté sauvage"),
        (18.5, "Les hélicoptères dans le ciel"),
        (22.5, "Semblent des libellules"),
        (26.5, "Et le vent dans les palmiers"),
        (30.5, "Chante l'été indien"),
        (35.0, "L'été indien"),
        (39.0, "Un indien dans la baie"),
        (43.0, "Un Glaswegian au pays du matador"),
    ]),
    ("champs-elysees", "Les Champs-Élysées", "Joe Dassin", "easy", "variete", [
        (2.0, "Je m'baladais sur l'avenue"),
        (5.5, "Le cœur ouvert à l'inconnu"),
        (9.0, "J'avais envie de dire bonjour"),
        (12.5, "À n'importe qui"),
        (16.0, "N'importe qui, ce fut toi"),
        (19.5, "Je t'ai dit n'importe quoi"),
        (23.0, "Il suffisait de te parler"),
        (26.5, "Pour t'apprivoiser"),
        (30.5, "Aux Champs-Élysées"),
        (34.0, "Aux Champs-Élysées"),
        (37.5, "Au soleil, sous la pluie"),
        (41.0, "À midi ou à minuit"),
        (44.5, "Il y a tout ce que vous voulez"),
        (48.5, "Aux Champs-Élysées"),
    ]),
    ("salut-amoureux", "Salut les amoureux", "Joe Dassin", "easy", "variete", [
        (2.0, "Les matins se lèvent"),
        (5.5, "Et la ville s'éveille"),
        (9.0, "Les amants s'embrassent"),
        (12.5, "Sur le bord des lèvres"),
        (16.5, "Salut les amoureux"),
        (20.0, "Qui se bécottent sur les trottoirs"),
        (24.5, "Salut les amoureux"),
        (28.0, "Qui s'aiment enlacés"),
        (31.5, "Dans la foule des passants"),
        (36.0, "Les matins se lèvent"),
        (39.5, "Et le jour est là"),
        (43.0, "Salut les amoureux"),
    ]),
    ("petit-pain", "Le petit pain au chocolat", "Joe Dassin", "easy", "variete", [
        (2.0, "Ils s'aiment bien, les petits croissants"),
        (5.5, "Les petits pains au chocolat"),
        (9.5, "C'est toujours pour les mêmes"),
        (13.0, "Que se lèvent les gourmands"),
        (17.0, "Ils s'aiment bien, les petits croissants"),
        (20.5, "Les petits pains au chocolat"),
        (24.5, "C'est toujours pour les mêmes"),
        (28.0, "Que se lèvent les gourmands"),
        (32.0, "Chacun son tour, c'est la règle"),
        (36.0, "Et les croissants se partagent"),
    ]),
    ("siffler-colline", "Siffler sur la colline", "Joe Dassin", "easy", "variete", [
        (2.0, "Siffler sur la colline"),
        (6.0, "À l'ombre des grands arbres"),
        (10.0, "Je t'attendrai, je t'aimerai"),
        (14.5, "Jusqu'à la fin des temps"),
        (19.0, "Siffler sur la colline"),
        (23.0, "Quand le vent souffle fort"),
        (27.0, "Sur la montagne, dans les blés"),
        (32.0, "Je t'attendrai, je t'aimerai"),
        (36.5, "Jusqu'à la fin des temps"),
    ]),

    # --- YVES MONTAND (2) ---
    ("feuilles-mortes", "Les feuilles mortes", "Yves Montand", "medium", "variete", [
        (2.0, "Les feuilles mortes se ramassent à la pelle"),
        (7.0, "Les souvenirs et les regrets aussi"),
        (12.0, "Et le vent du nord les emporte"),
        (17.0, "Dans la nuit froide de l'oubli"),
        (22.0, "Toi, tu étais jolie"),
        (26.0, "Je t'aimais beaucoup"),
        (30.0, "Nous vivions tous les deux"),
        (34.0, "Une vie monotone"),
        (38.5, "Mais le ciel bleu sur nous peut s'effondrer"),
        (44.0, "Et la terre peut bien s'écrouler"),
        (49.0, "Peu m'importe si tu m'aimes"),
    ]),
    ("cest-si-bon", "C'est si bon", "Yves Montand", "easy", "variete", [
        (2.0, "C'est si bon de partir n'importe où"),
        (6.5, "Avec toi, tout est beau"),
        (10.5, "C'est si bon d'être libre"),
        (14.5, "Avec toi, en été"),
        (18.5, "C'est si bon de vivre"),
        (22.5, "Quand on est amoureux"),
        (26.5, "C'est si bon de rêver"),
        (30.5, "De s'aimer, de s'aimer"),
        (35.0, "C'est si bon"),
        (38.5, "Quand on est amoureux"),
        (42.5, "C'est si bon"),
    ]),

    # --- CHARLES TRENET (3) ---
    ("la-mer", "La mer", "Charles Trenet", "easy", "variete", [
        (2.0, "La mer, qu'on voit danser"),
        (6.0, "Le long des golfes clairs"),
        (10.0, "A des reflets d'argent"),
        (14.0, "La mer, les pêcheurs savent"),
        (19.0, "Qu'elle est capricieuse"),
        (23.5, "La mer, quand elle est joyeuse"),
        (28.0, "Est belle à voir"),
        (32.5, "La mer, qu'on voit danser"),
        (37.0, "Au soleil d'été"),
        (41.5, "A des reflets de cuivre"),
        (46.0, "Et c'est une fille brune"),
        (50.5, "Qui sourit aux pêcheurs"),
    ]),
    ("douce-france", "Douce France", "Charles Trenet", "easy", "variete", [
        (2.0, "Il revient à ma mémoire"),
        (6.0, "Des souvenirs familiers"),
        (10.0, "Je revois la black couleur"),
        (14.0, "Des尽 aux chapeaux de paille"),
        (19.0, "Douce France"),
        (22.5, "Cher pays de mon enfance"),
        (27.0, "Bercée de tendres infirmières"),
        (32.0, "Je t'ai gardée dans mon cœur"),
        (36.5, "Douce France"),
        (40.0, "Au samaricain"),
        (44.0, "Tu es la plus belle"),
        (48.0, "Des pays que je connaisse"),
    ]),
    ("boum", "Boum !", "Charles Trenet", "easy", "variete", [
        (2.0, "Ça fait boum quand ça tombe"),
        (5.5, "Et ça fait un grand trou dans l'eau"),
        (10.0, "Ça fait boum dans ma tête"),
        (13.5, "Quand je pense à toi"),
        (17.0, "Boum !"),
        (19.5, "Quand mon cœur fait boum"),
        (23.0, "Boum !"),
        (25.5, "Quand je pense à toi"),
        (29.0, "Ça fait boum"),
        (32.0, "Dans mon cœur"),
        (35.0, "Un grand boum"),
    ]),

    # --- FRANCE GALL (4) ---
    ("poupee-cire", "Poupée de cire, poupée de son", "France Gall", "easy", "variete", [
        (2.0, "Mon cœur est en papier"),
        (5.5, "Ma vie est en vidéo"),
        (9.0, "Je suis une poupée de cire"),
        (12.5, "Une poupée de son"),
        (16.5, "Quand il me prend dans ses bras"),
        (20.0, "Il me parle tout bas"),
        (23.5, "Je crois que c'est de l'amour"),
        (27.5, "Mais c'est de la mousse"),
        (31.0, "Poupée de cire, poupée de son"),
        (35.5, "Mon cœur est en papier"),
        (39.0, "Ma vie est en vidéo"),
    ]),
    ("ella-elle-la", "Ella, elle l'a", "France Gall", "medium", "variete", [
        (2.0, "Un soir elle s'est pendue"),
        (6.5, "À une branche de lilas"),
        (11.0, "Comme une fleur"),
        (14.5, "Qui faisait de laicismo"),
        (19.0, "Elle, elle l'a"),
        (22.0, "Elle, elle l'a"),
        (25.0, "Elle a dit oui"),
        (28.5, "Elle a dit oui"),
        (32.0, "Elle, elle l'a"),
        (35.5, "Elle, elle l'a"),
        (39.0, "Elle a dit oui"),
        (42.5, "Contre le vent"),
        (46.0, "Contre le temps"),
    ]),
    ("babacar", "Babacar", "France Gall", "easy", "variete", [
        (2.0, "Il était une fois"),
        (5.5, "Un petit garçon noir"),
        (9.0, "Assis dans un coin"),
        (12.5, "Qui rêvait de voyager"),
        (17.0, "Babacar, Babacar"),
        (21.0, "Dis-moi Babacar"),
        (24.5, "Où est-ce que tu vas ?"),
        (28.0, "Jusqu'au bout de la mer"),
        (32.0, "Babacar, Babacar"),
        (36.0, "Dis-moi Babacar"),
        (39.5, "Comment je peux faire ?"),
        (43.0, "Pour aller là-bas"),
    ]),
    ("diego", "Diego, libre dans sa tête", "France Gall", "medium", "variete", [
        (2.0, "Dans sa tôle ondulée"),
        (6.0, "Séjourne la misère"),
        (10.5, "Où bat le tambour"),
        (14.0, "Où s'affrontent la faim et lesifiers"),
        (19.0, "Diego est triste"),
        (22.5, "Diego est beau"),
        (26.0, "Diego est libre dans sa tête"),
        (31.0, "Diego est libre"),
        (34.5, "Comme un oiseau"),
        (38.0, "Qui ne connaît pas la cage"),
        (43.0, "Diego est libre"),
        (46.5, "Dans sa tête"),
    ]),

    # --- MICHEL BERGER (3) ---
    ("groupie-pianiste", "La groupie du pianiste", "Michel Berger", "medium", "variete", [
        (2.0, "Elle était belle, elle était nue"),
        (6.5, "Elle était brune, elle était blonde"),
        (11.0, "Elle était belle"),
        (14.0, "La groupie du pianiste"),
        (18.0, "Elle avait des yeux de velours"),
        (22.0, "Elle avait des mains de princesse"),
        (27.0, "Elle était la groupie"),
        (31.0, "Du pianiste"),
        (34.5, "Elle montait sur scène"),
        (38.5, "Quand il jouait"),
        (42.0, "Elle criait, elle dansait"),
        (46.0, "Elle était folle"),
        (49.5, "De la groupie"),
    ]),
    ("quelques-mots", "Quelques mots d'amour", "Michel Berger", "easy", "variete", [
        (2.0, "Il y avait quelques mots"),
        (6.0, "Que je voulais te dire"),
        (10.0, "Des mots d'amour"),
        (13.5, "Des mots de toujours"),
        (17.5, "Quand je te vois"),
        (21.0, "Mon cœur se met à battre"),
        (25.0, "Je voudrais te dire"),
        (28.5, "Tout mon amour"),
        (32.5, "Quelques mots d'amour"),
        (36.5, "Que je n'ose pas dire"),
        (41.0, "Quelques mots d'amour"),
        (45.0, "Pour toi, pour moi"),
    ]),
    ("peu-de-blues", "Un peu de blues", "Michel Berger", "medium", "variete", [
        (2.0, "Un peu de blues dans la vie"),
        (6.5, "Un peu de blues dans le cœur"),
        (11.0, "Un peu de blues"),
        (14.0, "Quand tout va mal"),
        (18.0, "Un peu de blues"),
        (21.5, "Ça fait du bien"),
        (25.0, "Un peu de blues"),
        (28.5, "Dans la nuit"),
        (32.0, "Un peu de blues"),
        (35.5, "Pour oublier"),
        (39.0, "Un peu de blues"),
        (42.5, "Ça console"),
    ]),

    # --- MICHEL SARDOU (5) ---
    ("lacs-connemara", "Les lacs du Connemara", "Michel Sardou", "medium", "variete", [
        (2.0, "Les lacs du Connemara"),
        (6.5, "Ont des ondes si lourdes"),
        (11.0, "Que même les bateaux"),
        (15.0, "Ne peuvent les porter"),
        (19.5, "Les lacs du Connemara"),
        (24.0, "Ont desumières si vertes"),
        (28.5, "Que même les légendes"),
        (33.0, "Ne peuvent les approcher"),
        (38.0, "On y vient de très loin"),
        (42.5, "Pour entendre le vent"),
        (47.0, "Sur les lacs du Connemara"),
    ]),
    ("je-vais-t-aimer", "Je vais t'aimer", "Michel Sardou", "medium", "variete", [
        (2.0, "Quand nos deux corps"),
        (5.5, "Se recherchent"),
        (9.0, "Quand nos deux cœurs"),
        (12.5, "Se déchaînent"),
        (16.0, "Je vais t'aimer"),
        (20.0, "Comme on aime la vie"),
        (24.0, "Comme on aime le jour"),
        (28.0, "Qui se lève"),
        (32.0, "Je vais t'aimer"),
        (36.0, "Comme on aime le ciel"),
        (40.0, "Comme on aime la mer"),
        (44.0, "Et les étoiles"),
    ]),
    ("etre-une-femme", "Être une femme", "Michel Sardou", "medium", "variete", [
        (2.0, "Être une femme, c'est une présence"),
        (7.0, "C'est une élégance naturelle"),
        (12.0, "Être une femme, c'est une flamme"),
        (17.0, "Qui brûle dans la nuit"),
        (22.0, "Être une femme, c'est une arme"),
        (27.0, "Contre les coups du sort"),
        (32.0, "Être une femme, c'est un rêve"),
        (37.0, "Que l'on poursuit toute sa vie"),
        (42.0, "Être une femme"),
        (46.5, "C'est donner sans compter"),
    ]),
    ("villes-solitude", "Les villes de solitude", "Michel Sardou", "medium", "variete", [
        (2.0, "Dans les villes de solitude"),
        (6.5, "Où les gens se croisent sans se voir"),
        (11.5, "Où les cœurs se cherchent"),
        (15.5, "Sans jamais se trouver"),
        (20.0, "Dans les villes de solitude"),
        (24.5, "Les rues sont froides"),
        (28.5, "Les murs sont gris"),
        (32.5, "Et le vent souffle"),
        (36.5, "Sur les visages tristes"),
        (41.0, "Des villes de solitude"),
        (45.5, "Où l'amour n'existe pas"),
    ]),
    ("maladie-amour", "La maladie d'amour", "Michel Sardou", "easy", "variete", [
        (2.0, "C'est la maladie d'amour"),
        (6.0, "Quand tu me manques"),
        (9.5, "C'est la maladie d'amour"),
        (13.0, "Quand tu es loin"),
        (16.5, "C'est la maladie d'amour"),
        (20.5, "Qui me rend malade"),
        (24.0, "C'est la maladie d'amour"),
        (28.0, "Qui me rend fou"),
        (32.0, "Tu es mon médicament"),
        (36.0, "Tu es mon remède"),
        (40.0, "Tu es mon amour"),
    ]),

    # --- JEAN-JACQUES GOLDMAN (8) ---
    ("envole-moi", "Envole-moi", "Jean-Jacques Goldman", "medium", "variete", [
        (2.0, "Minuit se lève"),
        (5.0, "En haut des tours"),
        (8.0, "Les voix des mansardes"),
        (11.0, "Chantent la couleur des jours"),
        (15.0, "À venir"),
        (18.0, "Envole-moi, envole-moi"),
        (22.0, "Loin de cette fatalité"),
        (26.0, "Envole-moi, envole-moi"),
        (30.0, "Vers les étoiles"),
        (34.0, "Pour me faire pardonner"),
        (38.0, "De n'être qu'un homme"),
    ]),
    ("je-marche-seul", "Je marche seul", "Jean-Jacques Goldman", "medium", "variete", [
        (2.0, "Je marche seul dans la nuit"),
        (6.5, "Je marche seul sur les trottoirs"),
        (11.0, "Je cherche quelqu'un"),
        (14.5, "Qui me ressemble"),
        (18.5, "Je marche seul"),
        (22.0, "Dans la foule des gens"),
        (26.0, "Qui passent sans me voir"),
        (30.0, "Je marche seul"),
        (33.5, "Avec mes rêves"),
        (37.0, "Et mes espoirs"),
        (41.0, "Je marche seul"),
    ]),
    ("la-bas", "Là-bas", "Jean-Jacques Goldman", "medium", "variete", [
        (2.0, "Partir là-bas"),
        (5.5, "Où le ciel est bleu"),
        (9.0, "Où les oiseaux chantent"),
        (12.5, "Où tout est merveilleux"),
        (17.0, "Partir là-bas"),
        (20.5, "Où l'amour est roi"),
        (24.0, "Où les cœurs sont légers"),
        (27.5, "Où tout est possible"),
        (32.0, "Mais il faut y croire"),
        (36.0, "Et s'y rendre"),
        (40.0, "Là-bas, là-bas"),
    ]),
    ("il-suffira", "Il suffira d'un signe", "Jean-Jacques Goldman", "medium", "variete", [
        (2.0, "Il suffira d'un signe"),
        (6.0, "Un mot, un geste"),
        (9.5, "Et tout recommence"),
        (13.0, "Il suffira d'un signe"),
        (17.0, "Pour que tout s'arrête"),
        (21.0, "Pour que tout finisse"),
        (25.0, "Il suffira d'un signe"),
        (29.0, "D'un regard échangé"),
        (33.0, "Pour que tout s'allume"),
        (37.0, "Pour que tout s'enflamme"),
    ]),
    ("pas-la", "Pas là", "Jean-Jacques Goldman", "medium", "variete", [
        (2.0, "Pas là, pas là"),
        (5.0, "Tu n'es pas là"),
        (8.5, "Quand j'ai besoin de toi"),
        (12.0, "Pas là, pas là"),
        (15.5, "Tu n'es jamais là"),
        (19.0, "Quand je voudrais te voir"),
        (23.0, "Pas là, pas là"),
        (26.5, "Tu n'es pas là"),
        (30.0, "Et je t'attends"),
        (33.5, "Toute la nuit"),
        (37.0, "Pas là, pas là"),
    ]),
    ("encore-un-matin", "Encore un matin", "Jean-Jacques Goldman", "medium", "variete", [
        (2.0, "Encore un matin"),
        (6.0, "La terre tourne"),
        (9.5, "Encore un matin"),
        (13.0, "Le soleil se lève"),
        (17.0, "Encore un matin"),
        (20.5, "Un jour de plus"),
        (24.0, "Un jour de moins"),
        (28.0, "La vie continue"),
        (32.0, "Encore un matin"),
        (36.0, "À espérer"),
        (40.0, "À aimer"),
    ]),
    ("quand-musique-bonne", "Quand la musique est bonne", "Jean-Jacques Goldman", "easy", "variete", [
        (2.0, "Quand la musique est bonne"),
        (5.5, "Quand la musique est bonne"),
        (9.0, "Quand la musique est bonne"),
        (12.5, "Quand la musique est bonne"),
        (16.0, "J'oublie tous mes soucis"),
        (20.0, "Je me laisse aller"),
        (24.0, "Dans le creux de ta main"),
        (28.0, "Je me sens bien"),
        (32.0, "Quand la musique est bonne"),
        (36.0, "Tout le monde danse"),
        (40.0, "Tout le monde chante"),
    ]),
    ("cest-ta-chance", "C'est ta chance", "Jean-Jacques Goldman", "medium", "variete", [
        (2.0, "Si tu as la chance"),
        (6.0, "D'avoir quelqu'un qui t'aime"),
        (10.5, "C'est ta chance"),
        (14.0, "Saisis-la, saisis-la"),
        (18.0, "Si tu as la chance"),
        (22.0, "De trouver l'amour"),
        (26.0, "C'est ta chance"),
        (29.5, "Ne la laisse pas fuir"),
        (33.5, "Saisis-la, saisis-la"),
        (37.5, "Avant qu'il ne soit trop tard"),
    ]),

    # --- RENAUD (4) ---
    ("mistral-gagnant", "Mistral gagnant", "Renaud", "easy", "rock", [
        (2.0, "Pour être un vrai chef"),
        (5.5, "Faut être un peu gangster"),
        (9.0, "Moi j'suis pas un gangster"),
        (12.5, "J'suis juste un peu voyou"),
        (16.5, "Mistral gagnant"),
        (20.0, "Mistral gagnant"),
        (23.5, "Vent du nord, vent du sud"),
        (27.0, "Vent qui fait danser les blés"),
        (31.0, "Mistral gagnant"),
        (34.5, "Vent qui fait chanter les hommes"),
        (38.5, "Mistral gagnant"),
    ]),
    ("laisse-beton", "Laisse béton", "Renaud", "easy", "rock", [
        (2.0, "Laisse béton"),
        (4.5, "Laisse béton"),
        (7.0, "Laisse béton"),
        (9.5, "Touche pas à ma pote"),
        (13.0, "Laisse béton"),
        (15.5, "Laisse béton"),
        (18.0, "Touche pas à ma sœur"),
        (21.5, "Laisse béton"),
        (24.0, "Laisse béton"),
        (26.5, "Touche pas à mon frère"),
        (30.0, "Laisse béton"),
    ]),
    ("des-que-vent", "Dès que le vent soufflera", "Renaud", "medium", "rock", [
        (2.0, "Dès que le vent soufflera"),
        (6.5, "Je reprendrai la route"),
        (11.0, "Dès que les vents tourneront"),
        (15.0, "Je m'en irai par les chemins"),
        (19.5, "Je m'en irai par les sentiers"),
        (24.0, "Retrouver la liberté"),
        (28.5, "Dès que le vent soufflera"),
        (33.0, "Là-bas, là-bas"),
        (37.0, "Où le ciel est toujours bleu"),
        (42.0, "Où les oiseaux chantent"),
    ]),
    ("manhattan-kaboul", "Manhattan-Kaboul", "Renaud", "hard", "rock", [
        (2.0, "Petite,eee"),
        (5.0, "Morte dans un accident"),
        (8.5, "Sur l'avenue de Kaboul"),
        (13.0, "Petite,eee"),
        (16.0, "Morte au pays des mille et une nuits"),
        (21.0, "Manhattan-Kaboul"),
        (24.5, "Deux tours jumelles"),
        (28.0, "Deux tours de verre"),
        (31.5, "Deux tours de fer"),
        (35.0, "Qui s'écroulent"),
        (39.0, "Comme un château de cartes"),
        (43.5, "Manhattan-Kaboul"),
    ]),

    # --- ALAIN SOUCHON (4) ---
    ("foule-sentimentale", "Foule sentimentale", "Alain Souchon", "medium", "variete", [
        (2.0, "Oh la la la vie en rose"),
        (6.0, "Le rose qu'on nous propose"),
        (10.0, "D efeuilles mortes"),
        (14.0, "Des sanglots longs des ennuyeux"),
        (18.5, "Mais nous, on a la foule sentimentale"),
        (24.0, "On a la nostalgie des ballades"),
        (29.0, "Des tangos du dimanche"),
        (33.5, "Et la foule sentimentale"),
        (38.0, "Qui se rue dans les bras"),
        (42.5, "De ceux qui l'aiment"),
    ]),
    ("allo-maman", "Allô maman bobo", "Alain Souchon", "easy", "variete", [
        (2.0, "Allô maman bobo"),
        (5.5, "Maman comment tu vas ?"),
        (9.0, "J'ai pas mal au cœur"),
        (12.5, "J'ai pas mal au ventre"),
        (16.0, "Allô maman bobo"),
        (19.5, "J'ai un peu la fièvre"),
        (23.0, "Mais c'est pas grave"),
        (26.5, "J'ai un peu la grippe"),
        (30.0, "Mais c'est pas la peste"),
        (33.5, "Allô maman bobo"),
        (37.0, "Je suis pas bien loin"),
        (40.5, "J'arrive ce soir"),
    ]),
    ("telephone-pleure", "Le téléphone pleure", "Alain Souchon", "medium", "variete", [
        (2.0, "Le téléphone pleure"),
        (6.0, "Quand il n'y a personne"),
        (10.0, "Au bout du fil"),
        (13.5, "Le téléphone pleure"),
        (17.0, "Quand je suis seul"),
        (20.5, "Dans ma chambre"),
        (24.0, "Le téléphone pleure"),
        (27.5, "Et moi je suis là"),
        (31.0, "À écouter"),
        (34.5, "Ce silence"),
        (38.0, "Qui me dévore"),
    ]),
    ("rame", "Rame", "Alain Souchon", "medium", "variete", [
        (2.0, "Rame, rame, rame"),
        (5.0, "Sur l'océan"),
        (8.0, "Rame, rame, rame"),
        (11.0, "Contre le vent"),
        (14.5, "Rame, rame, rame"),
        (17.5, "Vers l'horizon"),
        (21.0, "Rame, rame, rame"),
        (24.0, "Dans la nuit"),
        (27.5, "Rame, rame, rame"),
        (30.5, "Jusqu'au bout du monde"),
        (34.5, "Rame, rame, rame"),
        (37.5, "Pour l'amour"),
    ]),

    # --- NINO FERRER (2) ---
    ("le-sud", "Le sud", "Nino Ferrer", "easy", "variete", [
        (2.0, "C'est unographique"),
        (5.5, "Le sud, c'est la lumière"),
        (9.5, "C'est les oliviers"),
        (13.0, "C'est le ciel bleu"),
        (17.0, "C'est la mer Méditerranée"),
        (21.5, "C'est les cigales"),
        (25.0, "C'est la chaleur"),
        (28.5, "C'est les vacances"),
        (32.5, "C'est le bonheur"),
        (36.5, "C'est le sud"),
        (40.0, "Le sud, c'est la vie"),
    ]),
    ("mirza", "Mirza", "Nino Ferrer", "easy", "variete", [
        (2.0, "J'aurais voulu être chien"),
        (5.5, "Pour être le chien de Mirza"),
        (9.5, "J'aurais voulu être chat"),
        (13.0, "Pour être le chat de Mirza"),
        (17.0, "Mais je ne suis qu'un homme"),
        (21.0, "Un pauvre homme"),
        (24.5, "Qui aime Mirza"),
        (28.5, "Mirza, Mirza"),
        (32.0, "Tu es la plus belle"),
        (36.0, "Mirza, Mirza"),
        (39.5, "Tu es ma reine"),
    ]),

    # --- VANESSA PARADIS (3) ---
    ("joe-taxi", "Joe le taxi", "Vanessa Paradis", "easy", "pop", [
        (2.0, "Joe le taxi"),
        (4.5, "Je suis Joe le taxi"),
        (7.0, "Je conduis la nuit"),
        (10.5, "Dans ma voiture jaune"),
        (14.0, "Joe le taxi"),
        (16.5, "Je connais les villes"),
        (20.0, "Par leur nom, par leur cœur"),
        (24.0, "Joe le taxi"),
        (26.5, "Je suis le roi"),
        (29.5, "De la nuit"),
        (32.5, "Dans ma voiture jaune"),
    ]),
    ("marilyn-john", "Marilyn et John", "Vanessa Paradis", "medium", "pop", [
        (2.0, "Marilyn et John"),
        (6.0, "Sur un banc dans un square"),
        (10.0, "Elle lui parle de ses rêves"),
        (14.0, "Lui, il lui parle de la mer"),
        (18.5, "Marilyn et John"),
        (22.5, "S'aiment sous la pluie"),
        (26.5, "Sur un banc dans un square"),
        (31.0, "La vie est belle"),
        (34.5, "Quand on s'aime"),
        (38.0, "Marilyn et John"),
        (42.0, "Sur un banc dans un square"),
    ]),
    ("be-my-baby", "Be my baby", "Vanessa Paradis", "easy", "pop", [
        (2.0, "Be my baby"),
        (5.0, "Be my baby"),
        (8.0, "Tu es si belle"),
        (11.5, "Quand tu souris"),
        (15.0, "Be my baby"),
        (18.0, "Be my baby"),
        (21.0, "Reste avec moi"),
        (24.5, "Ne me quitte pas"),
        (28.0, "Be my baby"),
        (31.0, "Be my baby"),
        (34.0, "Je t'aimerai"),
        (37.5, "Pour toujours"),
    ]),

    # --- CHRISTOPHE MAÉ (4) ---
    ("on-sattache", "On s'attache", "Christophe Maé", "easy", "pop", [
        (2.0, "On s'attache"),
        (5.0, "À des gens, à des choses"),
        (9.0, "On s'attache"),
        (12.0, "À des rêves, à des roses"),
        (16.5, "On s'attache"),
        (19.5, "Et puis un jour"),
        (22.5, "On se détache"),
        (26.0, "On s'attache"),
        (29.0, "À la vie, à l'amour"),
        (33.0, "On s'attache"),
        (36.0, "Pour toujours"),
    ]),
    ("belle-demoiselle", "Belle demoiselle", "Christophe Maé", "easy", "pop", [
        (2.0, "Belle demoiselle"),
        (5.5, "Qui me tourmentes"),
        (9.0, "Belle demoiselle"),
        (12.5, "Tu me rends fou"),
        (16.0, "Belle demoiselle"),
        (19.5, "Je t'aimerai"),
        (23.0, "Jusqu'à la fin"),
        (26.5, "De mes jours"),
        (30.0, "Belle demoiselle"),
        (33.5, "Reste avec moi"),
        (37.0, "Ne me quitte pas"),
    ]),
    ("jai-laisse", "J'ai laissé", "Christophe Maé", "medium", "pop", [
        (2.0, "J'ai laissé"),
        (5.0, "Mon âme chez toi"),
        (8.5, "J'ai laissé"),
        (11.5, "Mon cœur sur ta joue"),
        (15.5, "J'ai laissé"),
        (18.5, "Mes rêves dans tes bras"),
        (22.5, "J'ai laissé"),
        (25.5, "Ma vie avec toi"),
        (29.5, "J'ai laissé"),
        (32.5, "Tout mon amour"),
    ]),
    ("dingue", "Dingue, dingue, dingue", "Christophe Maé", "easy", "pop", [
        (2.0, "Dingue, dingue, dingue"),
        (5.0, "Je suis dingue de toi"),
        (8.5, "Dingue, dingue, dingue"),
        (11.5, "Tu me rends dingue"),
        (15.0, "Dingue, dingue, dingue"),
        (18.0, "Je suis fou de toi"),
        (21.5, "Dingue, dingue, dingue"),
        (24.5, "Tu me rends dingue"),
        (28.0, "Dingue, dingue, dingue"),
        (31.0, "De t'aimer"),
    ]),

    # --- STROMAE (5) ---
    ("papaoutai", "Papaoutai", "Stromae", "easy", "electro", [
        (2.0, "Dites-moi d'où il vient"),
        (5.5, "Enfin je saurai où je vais"),
        (9.0, "Maman dit que lorsqu'on cherche bien"),
        (13.5, "On finit toujours par trouver"),
        (18.0, "Elle dit qu'il n'est jamais très loin"),
        (22.0, "Qu'il part très souvent travailler"),
        (26.5, "Maman dit travailler c'est bien"),
        (31.0, "Bien mieux qu'être mal accompagné"),
        (36.0, "Papaoutai"),
        (39.0, "Papaoutai"),
        (42.0, "Papaoutai"),
    ]),
    ("alors-on-danse", "Alors on danse", "Stromae", "easy", "electro", [
        (2.0, "Qui dit étude dit travail"),
        (5.5, "Qui dit taf dit les thunes"),
        (9.0, "Qui dit argent dit dettes"),
        (12.5, "Qui dit crédit dit créance"),
        (16.5, "Qui dit dette dit huissier"),
        (20.0, "Et dire huissier dit assis dans la merde"),
        (25.0, "Alors on danse"),
        (28.0, "Alors on danse"),
        (31.0, "Alors on danse"),
        (34.0, "Alors on danse"),
    ]),
    ("formidable", "Formidable", "Stromae", "medium", "electro", [
        (2.0, "Formidable, formidable"),
        (5.5, "Tu es formidable, formidable"),
        (9.0, "Tu es formidable"),
        (12.0, "Vraiment formidable"),
        (15.5, "Tu es formidable"),
        (18.5, "C'est carrément formidable"),
        (22.0, "Tu es formidable"),
        (25.0, "Tu es formidable"),
        (28.5, "Formidable"),
        (31.5, "Tu es formidable"),
        (35.0, "Formidable"),
    ]),
    ("ta-fete", "Ta fête", "Stromae", "medium", "electro", [
        (2.0, "C'est ta fête"),
        (5.0, "C'est ta fête"),
        (8.0, "Tout le monde est invité"),
        (12.0, "C'est ta fête"),
        (15.0, "C'est ta fête"),
        (18.0, "Même les ennemis"),
        (22.0, "C'est ta fête"),
        (25.0, "C'est ta fête"),
        (28.0, "Danse, danse"),
        (31.5, "Danse, danse"),
        (35.0, "C'est ta fête"),
    ]),
    ("tous-les-memes", "Tous les mêmes", "Stromae", "medium", "electro", [
        (2.0, "Tous les mêmes"),
        (5.5, "Tous les mêmes"),
        (9.0, "Tous les hommes sont pareils"),
        (13.0, "Mains dans les poches"),
        (16.5, "Regard qui se baisse"),
        (20.0, "Tous les mêmes"),
        (23.5, "Tous les mêmes"),
        (27.0, "Tous les mêmes"),
        (30.5, "Tous les mêmes"),
        (34.0, "Vous n'êtes pas les mêmes"),
        (38.0, "Vous êtes toutes belles"),
    ]),

    # --- INDILA (2) ---
    ("derniere-danse", "Dernière danse", "Indila", "medium", "pop", [
        (2.0, "Ô ma douce souffrance"),
        (6.5, "Pourquoi tu t'acharnes"),
        (11.0, "Tu me déchires"),
        (14.5, "Encore le cœur"),
        (18.5, "Dans un cri de souffrance"),
        (23.0, "Je t'implore"),
        (26.5, "Dieu, que je te voie"),
        (31.0, "Dernière danse"),
        (35.0, "Dernière danse"),
        (39.0, "Dernière danse"),
        (43.0, "Dernière chance"),
    ]),
    ("tourner-vide", "Tourner dans le vide", "Indila", "medium", "pop", [
        (2.0, "Tourner dans le vide"),
        (6.0, "Vide de sens"),
        (9.5, "Tourner dans le vide"),
        (13.0, "À en perdre la tête"),
        (17.0, "J'aimerais tant"),
        (21.0, "Que tu reviennes"),
        (24.5, "Me chercher"),
        (28.0, "Me trouver"),
        (32.0, "Tourner dans le vide"),
        (36.0, "Sans toi"),
        (40.0, "C'est le vide"),
    ]),

    # --- LOUANE (2) ---
    ("avenir", "Avenir", "Louane", "easy", "pop", [
        (2.0, "Avenir"),
        (5.0, "On a tous un avenir"),
        (9.0, "Avenir"),
        (12.0, "On a tous une vie"),
        (16.0, "Avenir"),
        (19.0, "C'est demain"),
        (22.5, "C'est l'avenir"),
        (26.0, "Qui nous sourit"),
        (30.0, "Avenir"),
        (33.0, "On a tous un avenir"),
        (37.0, "Avenir"),
        (40.0, "C'est la vie"),
    ]),
    ("je-veux-vivre", "Je veux vivre", "Louane", "easy", "pop", [
        (2.0, "Je veux vivre"),
        (5.5, "Je veux vivre"),
        (9.0, "Je veux vivre"),
        (12.5, "Je veux vivre"),
        (16.0, "Vivre d'amour"),
        (19.5, "Vivre de rires"),
        (23.0, "Vivre de tout"),
        (26.5, "Vivre de rien"),
        (30.0, "Je veux vivre"),
        (33.5, "Je veux vivre"),
        (37.0, "Je veux vivre"),
        (40.5, "Je veux vivre"),
    ]),

    # --- ZAZ (4) ---
    ("je-veux", "Je veux", "Zaz", "easy", "pop", [
        (2.0, "Donne-moi une suite"),
        (6.0, "À l'hôtel, je veux"),
        (9.5, "Des bijoux de chez Chanel"),
        (13.0, "Je veux"),
        (15.5, "De l'amour, de la joie"),
        (19.0, "De la bonne humeur"),
        (22.5, "Ce n'est pas pour moi"),
        (26.0, "De la bonne réputation"),
        (29.5, "Je veux de l'amour"),
        (33.0, "De la joie, de la bonne humeur"),
        (37.5, "Ce n'est pas pour moi"),
        (41.0, "Je veux de l'amour"),
    ]),
    ("on-ira", "On ira", "Zaz", "medium", "pop", [
        (2.0, "On ira"),
        (5.5, "Où tu voudras"),
        (9.0, "On ira"),
        (12.5, "Jusqu'au bout du monde"),
        (16.5, "On ira"),
        (20.0, "Même si le monde"),
        (23.5, "Est grand"),
        (27.0, "On ira"),
        (30.5, "Ensemble"),
        (34.0, "On verra bien"),
        (37.5, "Ce que la vie"),
        (41.0, "Nous réserve"),
    ]),
    ("si", "Si", "Zaz", "medium", "pop", [
        (2.0, "Si j'étais un homme"),
        (6.5, "Je serais président"),
        (11.0, "Si j'étais un homme"),
        (14.5, "Je serais le roi du monde"),
        (19.0, "Si j'étais une femme"),
        (23.0, "Je serais reine"),
        (26.5, "Si j'étais une femme"),
        (30.0, "Je serais la plus belle"),
        (34.5, "Si, si, si"),
        (38.0, "Si j'avais un peu"),
        (41.5, "De pouvoir"),
    ]),
    ("eblouie-nuit", "Éblouie par la nuit", "Zaz", "medium", "pop", [
        (2.0, "Éblouie par la nuit"),
        (6.5, "Je ferme les yeux"),
        (10.0, "Pour mieux voir"),
        (13.5, "Tes lèvres qui sourient"),
        (18.0, "Éblouie par la nuit"),
        (22.5, "Je ferme les yeux"),
        (26.0, "Pour mieux voir"),
        (29.5, "Ton cœur qui bat"),
        (34.0, "Éblouie par la nuit"),
        (38.0, "Je rêve"),
        (41.5, "De toi"),
    ]),

    # --- ANGÈLE (3) ---
    ("balance-ton-quoi", "Balance ton quoi", "Angèle", "easy", "pop", [
        (2.0, "Balance ton quoi"),
        (5.5, "Balance ton quoi"),
        (9.0, "Balance ton quoi"),
        (12.5, "Si c'est pour me faire du mal"),
        (16.5, "Balance ton quoi"),
        (20.0, "Balance ton quoi"),
        (23.5, "Balance ton quoi"),
        (27.0, "Si c'est pour me faire pleurer"),
        (31.0, "Balance ton quoi"),
        (34.5, "Balance ton quoi"),
        (38.0, "Balance ton quoi"),
    ]),
    ("tout-oublier", "Tout oublier", "Angèle", "medium", "pop", [
        (2.0, "Tout oublier"),
        (5.5, "Les beaux jours"),
        (9.0, "Tout oublier"),
        (12.5, "Les mauvais jours"),
        (16.5, "Tout oublier"),
        (20.0, "Pour recommencer"),
        (24.0, "À zéro"),
        (27.5, "Tout oublier"),
        (31.0, "Et puis"),
        (34.5, "Tout recommencer"),
        (38.0, "Tout oublier"),
    ]),
    ("fever", "Fever", "Angèle & Dua Lipa", "easy", "electro", [
        (2.0, "Fever"),
        (5.0, "I got the fever"),
        (8.0, "Fever"),
        (11.0, "I got the fever"),
        (14.5, "Fever"),
        (17.5, "Can you feel it"),
        (21.0, "Fever"),
        (24.0, "I got the fever"),
        (27.5, "Fever"),
        (30.5, "Can you feel it"),
        (34.0, "Fever"),
    ]),

    # --- CLARA LUCIANI (3) ---
    ("la-grenade", "La grenade", "Clara Luciani", "easy", "pop", [
        (2.0, "La grenade"),
        (5.5, "Ça va péter"),
        (9.0, "La grenade"),
        (12.5, "Ça va péter"),
        (16.0, "Dans mes mains"),
        (19.5, "Dans mes rêves"),
        (23.0, "Dans mon cœur"),
        (26.5, "Ça va péter"),
        (30.0, "La grenade"),
        (33.5, "Ça va péter"),
        (37.0, "La grenade"),
        (40.5, "Ça va péter"),
    ]),
    ("la-derniere-fois", "La dernière fois", "Clara Luciani", "medium", "pop", [
        (2.0, "La dernière fois"),
        (6.0, "Que je t'ai vu"),
        (9.5, "Tu m'as dit"),
        (13.0, "Que tu reviendrais"),
        (17.0, "La dernière fois"),
        (21.0, "Que je t'ai cru"),
        (24.5, "Tu m'as menti"),
        (28.0, "Une fois de plus"),
        (32.0, "La dernière fois"),
        (36.0, "C'était la dernière"),
    ]),
    ("respire-encore", "Respire encore", "Clara Luciani", "easy", "pop", [
        (2.0, "Respire encore"),
        (5.5, "Respire encore"),
        (9.0, "Respire encore"),
        (12.5, "Respire encore"),
        (16.5, "Ça va aller"),
        (20.0, "Ça va aller"),
        (23.5, "Respire encore"),
        (27.0, "Respire encore"),
        (30.5, "Respire encore"),
        (34.0, "Respire encore"),
        (37.5, "Respire encore"),
    ]),

    # --- VIANNEY (3) ---
    ("pas-la-vianney", "Pas là", "Vianney", "easy", "pop", [
        (2.0, "Pas là"),
        (5.0, "Tu n'es pas là"),
        (8.0, "Pas là"),
        (11.0, "Quand j'ai besoin de toi"),
        (15.0, "Pas là"),
        (18.0, "Tu n'es pas là"),
        (21.0, "Quand je voudrais te voir"),
        (25.0, "Pas là"),
        (28.0, "Tu n'es pas là"),
        (31.0, "Et je t'attends"),
        (34.5, "Toute la nuit"),
    ]),
    ("beau-papa", "Beau-papa", "Vianney", "easy", "pop", [
        (2.0, "Beau-papa"),
        (5.5, "Tu es mon beau-papa"),
        (9.0, "Beau-papa"),
        (12.5, "Je t'aime comme mon papa"),
        (16.5, "Beau-papa"),
        (20.0, "Tu es le meilleur"),
        (23.5, "Beau-papa"),
        (27.0, "Tu es mon héros"),
        (30.5, "Beau-papa"),
        (34.0, "Je t'aimerai"),
        (37.5, "Pour toujours"),
    ]),
    ("le-reste", "Le reste", "Vianney", "medium", "pop", [
        (2.0, "Le reste"),
        (5.5, "Je te donne le reste"),
        (9.5, "De mon cœur"),
        (13.0, "De ma vie"),
        (17.0, "Le reste"),
        (20.5, "Je te donne le reste"),
        (24.5, "De mes nuits"),
        (28.0, "De mes jours"),
        (32.0, "Le reste"),
        (35.5, "De moi"),
        (39.0, "Pour toi"),
    ]),

    # --- KEEN'V (2) ---
    ("vie-bon-cote", "La vie du bon côté", "Keen'V", "easy", "pop", [
        (2.0, "La vie du bon côté"),
        (6.0, "C'est la vie qu'on aime"),
        (10.0, "La vie du bon côté"),
        (14.0, "C'est la vie qu'on veut"),
        (18.0, "La vie du bon côté"),
        (22.0, "On est bien"),
        (25.5, "On est heureux"),
        (29.0, "La vie du bon côté"),
        (33.0, "C'est la vie"),
        (36.5, "C'est la fête"),
        (40.0, "La vie du bon côté"),
    ]),
    ("jvoulais", "J'voulais", "Keen'V", "easy", "pop", [
        (2.0, "J'voulais"),
        (5.0, "J'voulais te dire"),
        (8.0, "J'voulais"),
        (11.0, "J'voulais te voir"),
        (14.5, "J'voulais"),
        (17.5, "J'voulais t'aimer"),
        (21.0, "J'voulais"),
        (24.0, "J'voulais t'embrasser"),
        (28.0, "J'voulais"),
        (31.0, "J'voulais te garder"),
        (34.5, "J'voulais"),
        (37.5, "J'voulais tout"),
    ]),

    # --- MAÎTRE GIMS (3) ---
    ("sapes-comme-jamais", "Sapés comme jamais", "Maître Gims", "easy", "rap", [
        (2.0, "Sapés comme jamais"),
        (5.5, "Sapés comme jamais"),
        (9.0, "Sapés comme jamais"),
        (12.5, "On est sapés comme jamais"),
        (16.5, "Sapés comme jamais"),
        (20.0, "Sapés comme jamais"),
        (23.5, "Sapés comme jamais"),
        (27.0, "On est sapés comme jamais"),
        (31.0, "Sapés comme jamais"),
        (34.5, "Sapés comme jamais"),
        (38.0, "Sapés comme jamais"),
    ]),
    ("bella", "Bella", "Maître Gims", "medium", "rap", [
        (2.0, "Bella"),
        (5.5, "Bella, bella"),
        (9.0, "Bella"),
        (12.5, "Bella, bella"),
        (16.0, "Elle est belle"),
        (19.5, "Elle est belle"),
        (23.0, "Bella"),
        (26.5, "Bella, bella"),
        (30.0, "Elle est si belle"),
        (33.5, "Elle est si belle"),
        (37.0, "Bella"),
    ]),
    ("est-ce-que-tu-maimes", "Est-ce que tu m'aimes", "Maître Gims", "medium", "rap", [
        (2.0, "Est-ce que tu m'aimes"),
        (6.0, "Est-ce que tu m'aimes"),
        (9.5, "Est-ce que tu m'aimes"),
        (13.0, "Dis-moi, dis-moi"),
        (16.5, "Est-ce que tu m'aimes"),
        (20.5, "Est-ce que tu m'aimes"),
        (24.0, "Est-ce que tu m'aimes"),
        (27.5, "Dis-moi, dis-moi"),
        (31.0, "Est-ce que tu m'aimes"),
        (35.0, "Est-ce que tu m'aimes"),
    ]),

    # --- AMEL BENT (2) ---
    ("ma-philosophie", "Ma philosophie", "Amel Bent", "medium", "pop", [
        (2.0, "Ma philosophie"),
        (6.0, "C'est de dire"),
        (9.5, "Que la vie est belle"),
        (13.0, "Ma philosophie"),
        (16.5, "C'est de croire"),
        (20.0, "En l'avenir"),
        (23.5, "Ma philosophie"),
        (27.0, "C'est de vivre"),
        (30.5, "Sans se prendre la tête"),
        (34.5, "Ma philosophie"),
        (38.0, "C'est d'aimer"),
    ]),
    ("je-veux-tout", "Je veux tout", "Amel Bent", "medium", "pop", [
        (2.0, "Je veux tout"),
        (5.5, "Je veux tout"),
        (9.0, "Je veux l'amour"),
        (12.5, "Je veux la gloire"),
        (16.0, "Je veux tout"),
        (19.5, "Je veux tout"),
        (23.0, "Je veux la vie"),
        (26.5, "Je veux le bonheur"),
        (30.0, "Je veux tout"),
        (33.5, "Je veux tout"),
        (37.0, "Je veux tout"),
    ]),

    # --- NIAGARA (1) ---
    ("amour-plage", "L'amour à la plage", "Niagara", "easy", "pop", [
        (2.0, "L'amour à la plage"),
        (6.0, "C'est les vacances"),
        (10.0, "L'amour à la plage"),
        (14.0, "C'est le soleil"),
        (18.0, "L'amour à la plage"),
        (22.0, "C'est la mer"),
        (25.5, "L'amour à la plage"),
        (29.5, "C'est les vagues"),
        (33.5, "L'amour à la plage"),
        (37.5, "C'est le sable chaud"),
        (41.5, "L'amour à la plage"),
    ]),

    # --- OTTAWAN (2) ---
    ("disco", "D.I.S.C.O.", "Ottawan", "easy", "electro", [
        (2.0, "D.I.S.C.O."),
        (4.5, "D.I.S.C.O."),
        (7.0, "D.I.S.C.O."),
        (9.5, "D.I.S.C.O."),
        (12.0, "D.I.S.C.O."),
        (14.5, "D.I.S.C.O."),
        (17.0, "D.I.S.C.O."),
        (19.5, "D.I.S.C.O."),
        (22.0, "D.I.S.C.O."),
        (24.5, "D.I.S.C.O."),
        (27.0, "D.I.S.C.O."),
    ]),
    ("hands-up", "Hands up", "Ottawan", "easy", "electro", [
        (2.0, "Hands up"),
        (5.0, "Hands up"),
        (8.0, "Hands up"),
        (11.0, "Hands up"),
        (14.0, "Hands up"),
        (17.0, "Hands up"),
        (20.0, "Hands up"),
        (23.0, "Hands up"),
        (26.0, "Hands up"),
        (29.0, "Hands up"),
        (32.0, "Hands up"),
    ]),

    # --- IMAGES (1) ---
    ("demons-minuit", "Les démons de minuit", "Images", "easy", "variete", [
        (2.0, "Les démons de minuit"),
        (6.0, "Sont là"),
        (9.5, "Les démons de minuit"),
        (13.0, "Dansent"),
        (16.5, "Les démons de minuit"),
        (20.0, "Chantent"),
        (23.5, "Les démons de minuit"),
        (27.0, "Sont fous"),
        (30.5, "Les démons de minuit"),
        (34.0, "Sont là"),
        (37.5, "Les démons de minuit"),
    ]),

    # --- DESIRELESS (1) ---
    ("voyage-voyage", "Voyage, voyage", "Desireless", "medium", "electro", [
        (2.0, "Voyage, voyage"),
        (6.0, "Plus loin que la nuit"),
        (10.0, "Et le jour"),
        (13.5, "Voyage, voyage"),
        (17.5, "Dans l'espace infini"),
        (22.0, "De l'infiniment grand"),
        (26.5, "Voyage, voyage"),
        (31.0, "Sur l'eau sacrée"),
        (35.0, "D'un fleuve indien"),
        (39.5, "Voyage, voyage"),
        (44.0, "Et jamais ne reviens"),
    ]),

    # --- PLASTIC BERTRAND (1) ---
    ("ca-plane", "Ça plane pour moi", "Plastic Bertrand", "easy", "rock", [
        (2.0, "Ça plane pour moi"),
        (5.0, "Ça plane pour moi"),
        (8.0, "Ça plane pour moi"),
        (11.0, "Ça plane pour moi"),
        (14.0, "Ça plane pour moi"),
        (17.0, "Loin des soucis"),
        (20.5, "Des bombes"),
        (23.5, "Tomber des bombes"),
        (27.0, "Ça me rend heureux"),
        (31.0, "Ça plane pour moi"),
    ]),

    # --- GILBERT MONTAGNÉ (2) ---
    ("sunlights-tropiques", "Les sunlights des tropiques", "Gilbert Montagné", "easy", "variete", [
        (2.0, "Les sunlights des tropiques"),
        (6.5, "Éclairent ma vie"),
        (11.0, "Les sunlights des tropiques"),
        (15.0, "Sont dans mon cœur"),
        (19.0, "Les sunlights des tropiques"),
        (23.5, "Me font rêver"),
        (28.0, "Les sunlights des tropiques"),
        (32.5, "De bonheur"),
        (36.5, "Les sunlights des tropiques"),
        (41.0, "Sont dans mon cœur"),
    ]),
    ("on-va-saimer", "On va s'aimer", "Gilbert Montagné", "easy", "variete", [
        (2.0, "On va s'aimer"),
        (6.0, "On va s'aimer"),
        (10.0, "Sur toutes les mers"),
        (14.0, "De la terre"),
        (18.0, "On va s'aimer"),
        (22.0, "On va s'aimer"),
        (26.0, "Dans les/forum"),
        (30.0, "Des grandes villes"),
        (34.0, "On va s'aimer"),
        (38.0, "On va s'aimer"),
        (42.0, "Jusqu'au bout du monde"),
    ]),

    # --- PATRICIA KAAS (1) ---
    ("mademoiselle-blues", "Mademoiselle chante le blues", "Patricia Kaas", "medium", "variete", [
        (2.0, "Mademoiselle chante le blues"),
        (7.0, "Assise sur un banc"),
        (12.0, "Dans un square"),
        (16.0, "Mademoiselle chante le blues"),
        (21.0, "Sa voix est douce"),
        (25.0, "Sa voix est triste"),
        (29.5, "Mademoiselle chante le blues"),
        (34.5, "Et le public écoute"),
        (39.0, "Mademoiselle chante le blues"),
        (44.0, "Pour oublier"),
    ]),

    # --- DANIEL BALAVOINE (3) ---
    ("le-chanteur", "Le chanteur", "Daniel Balavoine", "medium", "variete", [
        (2.0, "Le chanteur est là"),
        (6.0, "Il chante pour toi"),
        (10.0, "Le chanteur est là"),
        (14.0, "Il chante l'amour"),
        (18.0, "Le chanteur est là"),
        (22.0, "Sur la scène"),
        (26.0, "Sous les projecteurs"),
        (30.5, "Le chanteur est là"),
        (34.5, "Il donne son cœur"),
        (38.5, "Le chanteur est là"),
    ]),
    ("laziza", "L'Aziza", "Daniel Balavoine", "medium", "variete", [
        (2.0, "L'Aziza"),
        (6.0, "Je t'aime"),
        (9.5, "L'Aziza"),
        (13.0, "Tu es belle"),
        (17.0, "L'Aziza"),
        (20.5, "Je t'aimerai"),
        (24.0, "Jusqu'au bout du monde"),
        (29.0, "L'Aziza"),
        (32.5, "Tu es ma vie"),
        (36.5, "L'Aziza"),
        (40.0, "Mon amour"),
    ]),
    ("sauver-amour", "Sauver l'amour", "Daniel Balavoine", "medium", "variete", [
        (2.0, "Sauver l'amour"),
        (6.0, "C'est sauver la vie"),
        (10.0, "Sauver l'amour"),
        (14.0, "C'est sauver le monde"),
        (18.5, "Sauver l'amour"),
        (22.5, "C'est possible"),
        (26.5, "Sauver l'amour"),
        (30.5, "Il faut y croire"),
        (34.5, "Sauver l'amour"),
        (38.5, "Ensemble"),
        (42.5, "On peut tout"),
    ]),

    # --- FRANCIS CABREL (2) ---
    ("encre-yeux", "L'encre de tes yeux", "Francis Cabrel", "medium", "variete", [
        (2.0, "J'écris ton nom"),
        (5.5, "Sur le sable"),
        (9.0, "J'écris ton nom"),
        (12.5, "Dans le ciel"),
        (16.0, "L'encre de tes yeux"),
        (20.0, "Sur mon cœur"),
        (24.0, "Reste pour toujours"),
        (28.0, "L'encre de tes yeux"),
        (32.0, "Est ma vie"),
        (36.0, "L'encre de tes yeux"),
        (40.0, "Est mon âme"),
    ]),
    ("je-taime-a-mourir", "Je l'aime à mourir", "Francis Cabrel", "easy", "variete", [
        (2.0, "Elle a dû faire toutes les guerres"),
        (6.5, "Pour être aussi forte aujourd'hui"),
        (11.0, "Elle a dû faire"),
        (14.5, "Des hijos de froids"),
        (18.0, "Pour être aussi belle"),
        (22.0, "Elle a dû faire"),
        (25.5, "Des détours dans sa vie"),
        (29.5, "Mais je l'aime à mourir"),
        (34.0, "Elle a dû faire"),
        (37.5, "Des détours"),
        (41.0, "Je l'aime à mourir"),
    ]),
]

# ============================================================
# STYLES AUDIO (5 styles pour varier)
# ============================================================
STYLES = {
    'variete': {'bpm': 100, 'kick': [0, 2], 'snare': [1, 3], 'bass': [0, 1, 2, 3], 'chords': [[261.63, 329.63, 392.00], [220.00, 277.18, 329.63]]},
    'rock': {'bpm': 130, 'kick': [0, 1, 2, 3], 'snare': [1, 3], 'bass': [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5], 'chords': [[196.00, 246.94, 293.66], [164.81, 207.65, 246.94]]},
    'pop': {'bpm': 115, 'kick': [0, 1.5, 2, 3], 'snare': [1, 3], 'bass': [0, 2], 'chords': [[261.63, 329.63, 392.00], [293.66, 349.23, 440.00]]},
    'electro': {'bpm': 128, 'kick': [0, 1, 2, 3], 'snare': [1, 3], 'bass': [0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5], 'chords': [[220.00, 261.63, 329.63], [246.94, 293.66, 369.99]]},
    'rap': {'bpm': 90, 'kick': [0, 2], 'snare': [1, 3], 'bass': [0, 3], 'chords': [[130.81, 164.81, 196.00], [146.83, 174.61, 220.00]]},
}

# ============================================================
# FONCTIONS DE GÉNÉRATION
# ============================================================

def slugify(text):
    """Convertit un titre en slug pour le nom de dossier"""
    return text.lower().replace(' ', '-').replace("'", '').replace(',', '').replace('é', 'e').replace('è', 'e').replace('à', 'a').replace('ù', 'u').replace('ç', 'c')

def generate_lrc(song_id, title, artist, paroles):
    """Génère le contenu d'un fichier LRC"""
    lrc = f"[ti:{title}]\n"
    lrc += f"[ar:{artist}]\n"
    lrc += "[al:Tesla Karaoké Party - 100 chansons françaises]\n"
    lrc += "[by:Générateur automatique]\n"
    lrc += "[offset:0]\n\n"

    for time_sec, text in paroles:
        minutes = int(time_sec // 60)
        seconds = int(time_sec % 60)
        centiseconds = int((time_sec % 1) * 100)
        lrc += f"[{minutes:02d}:{seconds:02d}.{centiseconds:02d}]{text}\n"

    return lrc

def generate_audio(style_name, style, output_path, duration=60):
    """Génère un fichier audio WAV de démo pour un style donné"""
    sample_rate = 44100
    num_samples = sample_rate * duration
    samples = []
    beat_duration = 60 / style['bpm']
    loop_duration = beat_duration * 4

    # Progression d'accords
    chord_progression = style['chords']

    for i in range(num_samples):
        t = i / sample_rate
        loop_time = t % loop_duration
        beat_time = loop_time % beat_duration

        sample = 0

        # Kick ( grosse caisse )
        for kick_beat in style['kick']:
            if abs(beat_time - kick_beat * beat_duration) < 0.01:
                kick_env = math.exp(-(beat_time - kick_beat * beat_duration) * 20)
                sample += 0.6 * kick_env * math.sin(2 * math.pi * 50 * t)

        # Snare ( caisse claire )
        for snare_beat in style['snare']:
            if abs(beat_time - snare_beat * beat_duration) < 0.01:
                snare_env = math.exp(-(beat_time - snare_beat * beat_duration) * 15)
                sample += 0.3 * snare_env * (random.random() * 2 - 1)

        # Basse
        chord_index = int(loop_time / beat_duration) % len(chord_progression)
        bass_note = chord_progression[chord_index][0] / 2
        for bass_beat in style['bass']:
            if abs(beat_time - bass_beat * beat_duration) < 0.02:
                bass_env = math.exp(-(beat_time - bass_beat * beat_duration) * 8)
                sample += 0.25 * bass_env * math.sin(2 * math.pi * bass_note * t)

        # Accords (pads)
        for note in chord_progression[chord_index]:
            sample += 0.08 * math.sin(2 * math.pi * note * t)
            sample += 0.04 * math.sin(2 * math.pi * note * 2 * t)

        # Hi-hat léger
        if int(t * 20) % 2 == 0:
            sample += 0.03 * (random.random() * 2 - 1) * 0.5

        # Limiter
        sample = max(-1, min(1, sample))
        samples.append(int(sample * 32767))

    # Écrire le fichier WAV
    with wave.open(output_path, 'w') as wav:
        wav.setnchannels(1)
        wav.setsampwidth(2)
        wav.setframerate(sample_rate)
        wav.writeframes(struct.pack('<' + 'h' * len(samples), *samples))

    return len(samples) * 2 / 1024 / 1024  # Taille en Mo

def main():
    print("=" * 60)
    print("  GÉNÉRATEUR DE 100 CHANSONS FRANÇAISES")
    print("  Tesla Karaoké Party")
    print("=" * 60)

    # Créer le dossier songs s'il n'existe pas
    os.makedirs(SONGS_DIR, exist_ok=True)

    # Générer les fichiers audio de démo (5 styles)
    print("\n[1/3] Génération des fichiers audio de démo (5 styles)...")
    audio_files = {}
    for style_name, style in STYLES.items():
        audio_path = os.path.join(SONGS_DIR, f'_demo_{style_name}.wav')
        size = generate_audio(style_name, style, audio_path)
        audio_files[style_name] = f'songs/_demo_{style_name}.wav'
        print(f"  [OK] {style_name}.wav ({size:.1f} Mo)")

    # Générer les dossiers et fichiers LRC pour chaque chanson
    print(f"\n[2/3] Génération des {len(CHANSONS)} chansons...")
    manifest = []

    for i, (song_id, title, artist, difficulty, genre, paroles) in enumerate(CHANSONS, 1):
        # Créer le dossier de la chanson
        song_dir = os.path.join(SONGS_DIR, song_id)
        os.makedirs(song_dir, exist_ok=True)

        # Générer le fichier LRC
        lrc_content = generate_lrc(song_id, title, artist, paroles)
        lrc_path = os.path.join(song_dir, 'lyrics.lrc')
        with open(lrc_path, 'w', encoding='utf-8') as f:
            f.write(lrc_content)

        # Créer un lien symbolique ou copier l'audio (on utilise le style correspondant)
        audio_src = os.path.join(SONGS_DIR, f'_demo_{genre}.wav')
        audio_dst = os.path.join(song_dir, 'audio.wav')
        # Copier le fichier audio
        with open(audio_src, 'rb') as src, open(audio_dst, 'wb') as dst:
            dst.write(src.read())

        # Ajouter au manifest
        manifest.append({
            "id": song_id,
            "title": title,
            "artist": artist,
            "difficulty": difficulty,
            "genre": genre,
            "audioUrl": f"songs/{song_id}/audio.wav",
            "lyricsUrl": f"songs/{song_id}/lyrics.lrc"
        })

        if i % 10 == 0:
            print(f"  ... {i}/{len(CHANSONS)} chansons créées")

    print(f"  [OK] {len(CHANSONS)} chansons créées")

    # Écrire le manifest
    print("\n[3/3] Écriture du manifest.json...")
    manifest_path = os.path.join(SONGS_DIR, 'manifest.json')
    with open(manifest_path, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, ensure_ascii=False, indent=4)
    print(f"  [OK] manifest.json ({len(manifest)} chansons)")

    # Statistiques
    print("\n" + "=" * 60)
    print("  RÉSUMÉ")
    print("=" * 60)
    print(f"  Chansons totales : {len(manifest)}")
    genres_count = {}
    for song in manifest:
        genres_count[song['genre']] = genres_count.get(song['genre'], 0) + 1
    print(f"  Par genre :")
    for genre, count in sorted(genres_count.items(), key=lambda x: -x[1]):
        print(f"    - {genre}: {count} chansons")
    print(f"\n  Fichiers LRC créés : {len(CHANSONS)}")
    print(f"  Fichiers audio créés : {len(CHANSONS)} (+ 5 styles de démo)")
    print("\n  Prochaines étapes :")
    print("  1. Remplace les fichiers audio.wav par les vrais instrumentaux")
    print("  2. Ajuste les timestamps dans les fichiers .lrc si besoin")
    print("  3. git add . && git commit -m '100 chansons françaises' && git push")
    print("=" * 60)

if __name__ == '__main__':
    main()
