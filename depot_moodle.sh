#!/bin/bash

get_game_time() {
    start_time=$(cat debut.txt)
    now=$(date +%s)
    elapsed=$((now - start_time))
    total_minutes=$((1410 + elapsed / 60))  # 23h30 = 1410 minutes
    hour=$((total_minutes / 60))
    minute=$((total_minutes % 60))
    printf "%02d:%02d\n" "$hour" "$minute"
}

is_time_expired() {
    current=$(get_game_time)
    current_minutes=$((10#${current:0:2} * 60 + 10#${current:3:2}))
    deadline_minutes=1440  # minuit
    if [ "$current_minutes" -ge "$deadline_minutes" ]; then
        return 0
    else
        return 1
    fi
}

echo "Heure du jeu : $(get_game_time)"
if is_time_expired; then
    echo "Il est minuit passé... Le portail Moodle s'est fermé. Vous avez échoué à aider votre ami, qui vous en voudra à jamais."
    exit 1
fi

echo "Vérification du rendu..."

if [ ! -f "Moodle/rendu_GCU.tar" ]; then
    echo "Fichier rendu_GCU.tar introuvable."
    exit 1
fi

mkdir -p temp_verif
tar -xf Moodle/rendu_GCU.tar -C temp_verif

# Liste des corrections attendues
phrases_corrigees=(
"L'affaissement est mesuré au cône d'Abrams."
"La compacité maximale d'un béton est atteinte pour une granulométrie bien étalée."
"Le béton est généralement testé en compression 28 jours après son coulage."
"La contrainte est une force par unité de surface, autrement dit, une pression."
"La fonte est un alliage de fer et de carbone comme l'acier."
"Un superplastifiant peut être ajouté à votre béton pour une meilleure ouvrabilité."
"L'essai pressiométrique permet d'obtenir les caractéristiques du sol en appliquant une contrainte sur ses parois."
"Une poutre est définie par une forme allongée de section négligeable devant sa longueur."
)

# Lecture du contenu du fichier
contenu=$(cat "temp_verif/")

# Vérification
for phrase in "${phrases_corrigees[@]}"; do
    if [[ "$contenu" == "$phrase" ]]; then
        echo "Le projet a bien été déposé à temps sur Moodle. Félicitations, vous validez votre année."
        rm -r temp_verif
        kill $(cat temp_verif/clock.pid) 2>/dev/null
        exit 0
    fi
done

echo "Le projet a bien été déposé à temps sur Moodle, mais contient une faute, vous ne validez pas votre année."
exit 1
