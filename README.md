# devops-articles-api
# devops-articles-api


API Node.js (Express) connectée à une base de données PostgreSQL, entièrement conteneurisée avec Docker et automatisée via un pipeline CI/CD (GitHub Actions) avec déploiement sur runner local.

---

## Stack Technique

* **Runtime** : Node.js (v20)
* **Framework** : Express
* **Base de données** : PostgreSQL (15-alpine)
* **Conteneurisation** : Docker & Docker Compose
* **CI/CD** : GitHub Actions (GitHub Container Registry - GHCR & Runner local)

---

##  1. Exécution Locale

Pour lancer l'application et sa base de données directement sur votre machine de développement :

### Prérequis
* Docker et Docker Compose installés sur votre machine.

### Étapes d'installation et de lancement

1. **Cloner le dépôt :**
   ```bash
   git clone [https://github.com/Emerites45/devops-articles-api.git](https://github.com/Emerites45/devops-articles-api.git)
   cd devops-articles-api

docker compose up --build -d
Vérifier le bon fonctionnement :

Conteneurs actifs : docker ps

Logs de l'application : docker compose logs -f api

Test de l'API : curl http://localhost:3000

2. Fonctionnement du Pipeline CI/CD
Le projet utilise GitHub Actions pour automatiser la construction (build), la publication des images et le déploiement.

Architecture du Workflow (.github/workflows/docker-publish.yml)
Le pipeline se compose de deux jobs séquentiels déclenchés à chaque push sur la branche principale :

Job build-and-push (Runner Cloud Ubuntu) :

Récupère le code source.

Se connecte au registre de conteneurs GitHub (GHCR).

Construit l'image Docker multi-stage de l'API.

Pousse l'image versionnée sur GHCR (ghcr.io/...).

Job deploy-local (Runner Local) :

S'exécute uniquement si le job précédent a réussi (needs: build-and-push).

Utilise un Self-Hosted Runner configuré sur la machine hôte.

Récupère la dernière version de l'image depuis GHCR (docker compose pull).

Redémarre l'application à chaud sans interruption majeure (docker compose up -d --build).

Gestion du Runner Local
Pour que le déploiement automatique fonctionne, le service du runner local doit être actif sur la machine cible :

Bash


# Lancement interactif du runner
cd ~/actions-runner && ./run.sh   
