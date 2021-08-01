#!/bin/bash

##============================================================================================##
##                                                                                            ##
##                           Script docker_network_create_macvlan.sh                          ##
##                                                                                            ##
## Script de création d'interface virtuelle pour les conteneurs qui auront une IP macvlan     ##
## Voir tutos :                                                                               ##
## https://www.nas-forum.com/forum/topic/69319-tuto-docker-macvlan-pi-hole/                   ##
## https://www.nas-forum.com/forum/topic/67311-tuto-certificat-ssl-reverse-proxy-via-docker/  ##
##                                                                                            ##
## Les IPs prévues pour les conteneurs sont :                                                 ##
## - Conteneur A :  192.168.xxx.yyy                                                           ##
## - AdGuard-Home : 192.168.xxx.ooo                                                           ##
##                                                                                            ##
## Rappels des différentes IP :                                                               ##
## - Plage d'IP macvlan :  192.168.xxx.MMM/28                                                 ##
## - IP virtuelle unique : 192.168.xxx.zzz/32                                                 ##
## - IP conteneur n°1 :    192.168.xxx.yyy                                                    ##
## - IP conteneur n°2 :    192.168.xxx.ooo                                                    ##
## - Plage d'IP du LAN :   192.168.xxx.0/24                                                   ##
## - Passerelle/routeur :  192.168.xxx.1                                                      ##
##                                                                                            ##
##==============================================================================================

##==============================================================================================
##                                                                                            ##
## --ip-range=192.168.xxx.MMM/28 : cela correspond à la plage d'IP pour le réseau macvlan     ##
## sachant que 192.168.xxx.MMM doit être la 1ère IP donnée par les calculateurs internet.     ##
## Il se peut que ce ne soit pas la même que l'IP macvlan que l'on veut donner au conteneur   ##
## AdGuardHome.                                                                               ##
##                                                                                            ##
## Quelques calculateurs internet :                                                           ##
## https://cric.grenoble.cnrs.fr/Administrateurs/Outils/CalculMasque/                         ##
## https://www.cidr.eu/en/calculator/+/192.168.2.208/28                                       ##
##                                                                                            ##
##==============================================================================================


docker network create -d macvlan \
--subnet=192.168.xxx.0/24 \
--ip-range=192.168.xxx.MMM/28 \
--gateway=192.168.xxx.1 \
-o parent=eth0 \              # Ici, eth0 est à remplacer par votre interface réseau : eth0, ovs_eth0 ou autre...
macvlan-network

##==============================================================================================
## Pour exemple, voilà mes valeurs à moi :                                                    ##
##                                                                                            ##
## - Conteneur A :  192.168.2.209                                                             ##
## - AdGuard-Home : 192.168.2.210                                                             ##
## - Conteneur B :  192.168.2.211                                                             ##
##                                                                                            ##
## Rappels des différentes IP :                                                               ##
## - Plage d'IP macvlan :  192.168.xxx.MMM/28  ==  192.168.2.208/28                           ##
## - IP virtuelle unique : 192.168.xxx.zzz/32  ==  192.168.2.210/32                           ##
## - Plage d'IP du LAN :   192.168.xxx.0/24    ==  192.168.2.0/24                             ##
## - Passerelle/routeur :  192.168.xxx.1       ==  192.168.2.1                                ##
##==============================================================================================
