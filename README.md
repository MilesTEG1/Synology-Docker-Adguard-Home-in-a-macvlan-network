# Synology Docker : Install Adguard Home in a macvlan network [French Edition] <!-- omit in toc -->

## Table of Contents <!-- omit in toc -->

- [1. Introduction](#1-introduction)
  - [1.1. Présentation du tutoriel et prérequis](#11-présentation-du-tutoriel-et-prérequis)
  - [1.2. Quelques sources d'inspiration qui m'ont permis de faire ce tutoriel](#12-quelques-sources-dinspiration-qui-mont-permis-de-faire-ce-tutoriel)
  - [1.3. Fichiers disponibles sur ce dépôt](#13-fichiers-disponibles-sur-ce-dépôt)
- [2. blabbla](#2-blabbla)
  - [2.1. blabbla](#21-blabbla)
    - [blabbla](#blabbla)

# 1. Introduction

## 1.1. Présentation du tutoriel et prérequis

Ce tutoriel propose une méthode pas à pas pour installer Adguard Home sur un NAS Synology avec Docker et un réseau macvlan.

**Difficulté : *facile-moyenne***

<span color="red">redtext</span>

Pour suivre ce tutoriel, vous devrez :

- avoir installé Docker sur un NAS compatible ;
- savoir utiliser la ligne de commande pour se connecter en SSH au NAS ;
- avoir installé Portainer (facultatif) ;
- savoir se servir de la commande `docker-compose up -d` pour créer un conteneur (si vous ne passez pas par Portainer).

Si tel n'était pas le cas, voici quelques tutos utiles :

- [[TUTO] Docker : Introduction](https://www.nas-forum.com/forum/topic/65309-tuto-docker-introduction/) (sur nas-forum.com)
- [[TUTO] Centralisation des instances Docker](https://www.nas-forum.com/forum/topic/66422-tuto-centralisation-des-instances-docker/) (c'est Portainer) (sur nas-forum.com)
- [[TUTO] Accéder à son nas en ligne de commande](https://www.forum-nas.fr/viewtopic.php?f=56&t=11461) (sur forum-nas.com)

## 1.2. Quelques sources d'inspiration qui m'ont permis de faire ce tutoriel

Lorsque j'ai mis en place Adguard Home pour la première fois, c'était en bridge, mais ça avait occasionné quelques soucis de reconnaissances d'IP des machines qui étaient toutes celle du NAS. Puis j'ai essayé en host, mais là avec tous les ports que ça bloquait, et à l'époque, impossible d'utiliser AdGuard Home depuis la connexion au serveur VPN du NAS... <br/>
Je me suis donc aidé des tutoriaux ci-dessous pour faire une installation en macvlan afin de donner une adresse IP propre au conteneur Adguard Home :

- [[TUTO] [Docker - macvlan] Pi-hole](https://www.nas-forum.com/forum/topic/69319-tuto-docker-macvlan-pi-hole/) (sur nas-forum.com)
- [[TUTO] Certificat SSL & reverse proxy via Docker](https://www.nas-forum.com/forum/topic/67311-tuto-certificat-ssl-reverse-proxy-via-docker/)  (sur nas-forum.com)

Je remercie [.Shad.](https://www.nas-forum.com/forum/profile/74532-shad/) de Nas-Forum pour ses deux tutos et son autorisation de réutiliser certaines de ces explications sur le macvlan.

## 1.3. Fichiers disponibles sur ce dépôt

Outre ce [README.md](https://github.com/MilesTEG1/Synology-Docker-Adguard-Home-in-a-macvlan-network/blob/main/README.md) et la licence, il y a trois autres fichiers indispensables dont je parlerais plus bas :

- `docker-compose.yml` : permet la construction du conteneur ;
- `docker_network_create_macvlan.sh` : script permettant de créer le réseau macvlan *(exécution initiale unique)* ;
- `bridgemacvlan-interface.sh` : script permettant de créer l'interface virtuelle *(exécution initiale puis à chaque redémarrage du NAS à l'aide d'une **tâche planifiée**)*.

# 2. blabbla




## 2.1. blabbla

### blabbla