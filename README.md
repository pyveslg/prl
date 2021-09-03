# Prl_

Votez pour les meilleurs commits de votre batch.

<a href="https://www.wagonprl.com/"><img src="https://raw.githubusercontent.com/lewagon/fullstack-images/master/uikit/logo.png" width="250" /></a>

## Installation

Nécessite Ruby 2.6.6.

Créer un fichier `.env` à la racine contenant les lignes suivantes:

- `COOKIE=…` : se connecter à [Kitt](https://kitt.lewagon.com/), et récupérer
  les cookies envoyés, commençant par `_kitt2017_…`.
- `GITHUB_ACCESS_TOKEN=…` : pour créer un access token GitHub, aller dans
  `Settings` > `Developer Settings` > `Create Personal access token`.
  Vous n’avez pas besoin de cocher des permissions particulières car cette clef
  sera utilisée uniquement pour faire des requêtes vers des informations
  publiques.

Enfin, lancer `bin/setup`.


## Déploiement

```sh
$ git push heroku master
$ heroku run rails db:migrate db:seed
```

## Pour tester l'integration Omniauth

En premier lieu, créer une app OAuth sur GitHub. `profile` > `developper settings` > `New OAuth App`.
Application Name : WagonPRL
Homepage URL : http://localhost:3000 (ou votre url de dev si elle est differente)
Authorization callback URL : Un host public est necessaire, github ne peut renvoyer le callback vers localhost. Ngrok FTW !

```sh
$ brew install ngrok
$ ngrok http 3000
```

vous avez maintenant une URL publique (http://letters_and_numbers.ngrok.io)

l'Authorization callback URL va donc ressembler à
`http://3aa8f0f7.ngrok.io/users/auth/github/callback`

Une fois cette information ajoutée sur GitHub : `Register aplication`

Copier les clés fournies par github dans .env :
- `GITHUB_ID=...`
- `GITHUB_SECRET=...`

et ajouter votre host ngrok :

- `NGROK_HOST=something.ngrok.io` (remplacez something par votre sous domaine ngrok evidemment)

N’oubliez pas de redémarrer votre `rails s` !
