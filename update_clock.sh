#!/bin/bash
while true; do
    start_time=$(cat debut.txt)
    now=$(date +%s)
    elapsed=$((lnow - start_time))
    total_minutes=$((1410 + elapsed / 60))  # 23h30
    hour=$((total_minutes / 60))
    minute=$((total_minutes % 60))
    printf "%02d:%02d\n" "$hour" "$minute" > horloge.txt

    if [ "$hour" -ge 24 ]; then
        echo "Il est minuit passé... Le portail Moodle s'est fermé. Vous avez échoué à aider votre ami, qui vous en voudra à jamais." 
        echo "00:00" > horloge.txt
        break
    else
        printf "%02d:%02d\n" "$hour" "$minute" > horloge.txt
    fi
    sleep 30

done
