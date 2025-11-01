#!/bin/bash

#Installation 
sudo apt install gnupg gnupg-agent

# Dossier racine
mkdir fichiers

mkdir Moodle

# Sous-dossiers aléatoires

mots=("cours" "td" "tp" "exos" "devoirs" "révisions" "fiches" "polycopié" "annales" "corrigés" "supports" "slides" "résumé" "bibliographie" "projet" "rapport" "mémoire" "soutenance" "notes")


for i in {1..7}; do
    racine="${mots[$RANDOM % ${#mots[@]}]}_$((RANDOM % 10))"
    mkdir -p "fichiers/$racine"

    # Niveau 1
    niveau1="${mots[$RANDOM % ${#mots[@]}]}_$((RANDOM % 10))"
    mkdir -p "fichiers/$racine/$niveau1"

    # Niveau 2
    niveau2="${mots[$RANDOM % ${#mots[@]}]}_$((RANDOM % 10))"
    mkdir -p "fichiers/$racine/$niveau1/$niveau2"

    # Niveau 3
    niveau3="${mots[$RANDOM % ${#mots[@]}]}_$((RANDOM % 10))"
    mkdir -p "fichiers/$racine/$niveau1/$niveau2/$niveau3"


    done

# Sélection d'un sous-dossier aléatoire dans l'arborescence de fichiers/
dossier_rapport=$(find fichiers -mindepth 2 -type d | shuf -n 1)

# Création du fichier avec la faute

phrases_fautes=(
"L'affaissement est mesurer au cône d'Abrams."
"La compacitée maximale d'un béton est atteinte pour une granulométrie bien étalée."
"Le béton est généralement testé en compression 28 jour après son coulage."
"La contrainte et une force par unité de surface, autrement dit, une pression."
"La fonte est un alliage de fer et de carbonne comme l'acier."
"Un superplastifiant peut être ajouté a votre béton pour une meilleure ouvrabilité."
"L'essai pressiométrique permet d'obtenire les caractéristiques du sol en appliquant une contrainte sur ses parois."
"Une poutre est définie par une forme alongée de section négligeable devant sa longueur."
)

phrase="${phrases_fautes[$RANDOM % ${#phrases_fautes[@]}]}"
echo "$phrase" > "$dossier_rapport/projet_final.txt"


# Liste de 20 mots liés aux télécoms
genie_civil_mots=("béton" "acier" "fondation" "poutre" "dalle" "coffrage" "ferraillage" "chantier" "terrassement" "grue" "structure" "maçonnerie" "étaiement" "nivellement" "topographie" "cadastre" "assainissement" "voirie" "charpente" "isolation")


# Tirage aléatoire du mot de passe
mot_de_passe="${genie_civil_mots[$RANDOM % ${#genie_civil_mots[@]}]}"

# Création du dossier et encodage du mot de passe
mkdir -p fichiers/mots_de_passe
echo "$mot_de_passe" | base64 > fichiers/mots_de_passe/mdp.txt


#Chiffrement du fichier
gpg --batch --yes --passphrase "$mot_de_passe" -c "$dossier_rapport"/projet_final.txt
rm -f "$dossier_rapport"/projet_final.txt

# Permissions en lecture seule
chmod 444 "$dossier_rapport/projet_final.txt.gpg"

# Initialisation de l'horloge
date +%s > debut.txt

chmod +x depot_moodle.sh
chmod +x update_clock.sh
./update_clock.sh & 
echo $! > clock.pid


echo "DE : prof-gcu@insa-lyon.fr"
echo "A : eleve-gcu@insa-lyon.fr"
echo "Il est 23h30. Vous avez jusqu’à minuit pour rendre votre projet"
echo "Bonne chance…"
