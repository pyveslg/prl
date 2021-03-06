# Prl_

Votez pour les meilleurs messages de commits de votre batch!

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
