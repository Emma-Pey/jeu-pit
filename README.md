# Manuel du joueur – Panique en GCU
Bienvenue dans le jeu **Panique en GCU**. Vous êtes étudiant TC et votre ami de GCU vous appelle en catastrophe à 23h30 en vous annonçant que le projet sur lequel il avait tant travaillé a disparu, alors qu’il doit le rendre avant minuit ce soir !
Il ne connaît pas bien sa machine Linux, alors il fait appel à vous et à vos connaissances pour lui sauver la mise. Vous devrez lui dicter les commandes qui lui permettront de rendre son projet sur Moodle. 

---
## Démarrer le jeu
Rentrez `git clone https://github.com/Emma-Pey/jeu-pit.git` pour télécharger le jeu.

Tapez `chmod +x lancer_jeu.sh` pour rendre le fichier exécutable.

Exécutez `lancer_jeu.sh` pour commencer la partie. 
> Note : le fichier installe la commande `gpg`. Vous serez sûrement amené à rentrer `y` pour confirmer l'installation. 

## Déroulement du jeu

Votre ami se rappelle avoir nommé son fichier `projet` ou `rendu`. Ce fichier est protégé par un mot de passe, et contient une faute. À vous de dicter les bonnes commandes à votre ami pour : 
- le retrouver, 
- le déverrouiller, 
- et le corriger.

Finalement, il faudra 
- l’archiver sous le nom `rendu_GCU.tar`,
- le déposer dans le dossier nommé `Moodle`
- et valider le rendu en lançant le script `depot_moodle.sh`.

Vous pouvez à tout moment consulter l’heure en affichant le contenu du fichier `horloge.txt`. 
*Bonne chance, vous avez jusqu’à minuit.*

---
## Indices
- Votre ami n’est pas un professionnel de la cybersécurité, retrouver le mot de passe devrait être simple comme bonjour. 
- Le mot de passe a un aspect étrange ? Votre ami vous annonce, fier de lui, qu’il a récemment regardé une vidéo sur l’encodage en base 64 et a pensé que ce serait une bonne façon de protéger son mot de passe...
---
## Commandes utiles
### Décoder en base64
```
base64 -d mot_secret.txt
```
### Déchiffrer un fichier GPG
```
gpg --batch --yes --passphrase "motdepasse" -o dechiffre.txt -d chiffre.txt.gpg
```
> Cette commande déchiffre un fichier `.gpg` en utilisant une phrase secrète. Le fichier déchiffré est enregistré sous `fichier_dechiffre.txt`.
#### Astuce
```
sudo apt install gnupg gnupg-agent
```
> Si la commande gpg ne fonctionne pas
---
# Infos
L’arborescence des fichiers, le mot de passe, les modifications à réaliser changent à chaque lancement du jeu. Vous pouvez donc rejouer autant de fois que vous le voulez !
## Explication des scripts
| Script              | Rôle                                                                 |
|---------------------|----------------------------------------------------------------------|
| `lancer_jeu.sh`     | Initialise le jeu, génère les fichiers, choisit une phrase fautive, démarre l’horloge |
| `update_clock.sh`   | Simule l’heure du jeu (de 23h30 à minuit), met à jour `horloge.txt` |
| `depot_moodle.sh`   | Vérifie l’heure, extrait l’archive, valide la correction du fichier |
## Pour aller plus loin 
- Ajouter un système de score (par exemple la note de l’étudiant GCU dépend de la vitesse à laquelle le jeu a été terminé, ou du nombre de dépots moodle réalisés)
- Ajouter d’autres mini-jeux qui font utiliser d’autres commandes bash (par exemple avec `useradd`)
- Ajouter plusieurs niveaux de difficulté (qui changeraient le nombre d’erreurs autorisées ou le temps imparti)


