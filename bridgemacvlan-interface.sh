#!/bin/bash

##===========================================================================================##
##                      Script bridgemacvlan-interface.sh                                    ##
##                                                                                           ##
## Script de création d'interface virtuelle pour les conteneurs en macvlan                   ##
## Voir tutos :                                                                              ##
## https://www.nas-forum.com/forum/topic/69319-tuto-docker-macvlan-pi-hole/                  ##
## https://www.nas-forum.com/forum/topic/67311-tuto-certificat-ssl-reverse-proxy-via-docker/ ##
##                                                                                           ##
## Vérifier la bonne création de l'interface avec la commande suivante :                     ##
##      ifconfig | grep -A 9 macv0   
##                                                                                           ##
## Rappels des différentes IP :                                                              ##
## - Plage d'IP macvlan :  192.168.xxx.MMM/28  ==  192.168.2.208/28                          ##
## - IP virtuelle unique : 192.168.xxx.zzz/32  ==  192.168.2.210/32                          ##
## - Plage d'IP du LAN :   192.168.xxx.0/24    ==  192.168.2.0/24                            ##
## - Passerelle/routeur :  192.168.xxx.1       ==  192.168.2.1                               ##
## - IP conteneur n°1 :    192.168.xxx.yyy     == 192.168.2.209                              ##
## - IP conteneur n°2 :    192.168.xxx.ooo     == 192.168.2.210     AdGuard_Home             ##
##                                                                                           ##
##=============================================================================================

# Set timeout to wait host network is up and running
sleep 60

echo "$(date "+%R:%S - ") Script de création d'une interface virtuelle pour le NAS"
echo "$(date "+%R:%S - ") Exécution des commandes..."

ip link add macv0 link eth0 type macvlan  mode bridge   # macv0 : est le nom données à l'interface virtuelle
                                                        # eth0 : est l'interface réseau utilisée sur le NAS (lorsque VMM n'est pas utilisé)
                                                        #        si VMM est utilisé, ce sera ovs_eth0
ip addr add 192.168.xxx.zzz/32 dev macv0            # Adresse IP virtuelle 192.168.x.zzz/32  --  Il faut que cette adresse soit libre dans le réseau
                                                    # et qu'elle ne fasse pas partie du DHCP du routeur/box
                                                    # 
                                                    #### Dans mon cas, c'est cette commande :
                                                    #### ip addr add 192.168.2.230/32 dev macv0

ip link set dev macv0 address 5E:00:01:02:03:04     # MAC adresse pour l'adaptateur ayant l'IP virtuelle 
                                                    # Il faut que l'adresse MAC respecte ces conditions :
                                                    #   - Elle n'existe pas déjà sur mon hôte et sur mon réseau.
                                                    #   - Elle respecte la base hexadécimale, les notations allant de 0 à F.
                                                    #   - Le premier nombre doit être pair, ici 5E = 94 en base 10, c'est donc OK (vous pouvez
                                                    #     utiliser un convertisseur en ligne, ou faire vos divisions euclidiennes).
                                                    #     S'il est impair, vous aurez un message :
                                                    #           RTNETLINK answers: Cannot assign requested address
ip link set macv0 up

ip route add 192.168.xxx.MMM/28 dev macv0           # 192.168.xxx.MMM/28 : Plage d'adresse macvlan
                                                    # IP réellement disponible : voir les calculateurs internet
                                                    # Utiliser Portainer ou l'interface Docker ou encore le script : create-macvlan-network.sh
                                                    # 
                                                    #### Dans mon cas, c'est cette commande :
                                                    #### ip route add 192.168.2.208/28 dev macv0

echo "$(date "+%R:%S - ") Script terminé"
exit
