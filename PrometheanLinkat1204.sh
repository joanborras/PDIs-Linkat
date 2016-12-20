#! /bin/bash
# Script d'instal·lació del programari Promethean i Active Inspire per Linkat 12.04
# Copyright JBA 2014
#
#
clear
#
# Operacions prèvies
# 
#Afegir els repositoris
echo -e "\n*****************************\nAfegint els repositoris...\n*****************************\n"
sudo add-apt-repository 'deb http://activsoftware.co.uk/linux/repos/ubuntu precise oss non-oss'
#
# Descarregar el certificat
echo -e "\n*********************************\nDescarregant el certificat...\n*********************************\n"
sudo wget http://www.activsoftware.co.uk/linux/repos/Promethean.asc
# 
# Instal·lar el certificat
echo -e "\n*****************************\nInstal·lant el certificat...\n******************************\n"
sudo apt-key add Promethean.asc
# 
#
# Instal·lar el programari PDI Promethean
# Actualització de paquets
echo -e "\n*****************************\nActualitzant el sistema...\n******************************\n"
sudo apt-get update
#
# Instal·lació del programari de la PDI
echo -e "\n****************************************\nInstal·lant el programari de la PDI...\n****************************************\n"
sudo apt-get install activ-meta-ca
#
# Habilitar el reconeixement d'escriptura en català
sudo apt-get install activhwr-ca
#
# Reiniciar l'equip per aplicar els canvis
echo -e "\n**************************************************\nPer aplicar els canvis cal que reinicieu el sistema.\nPremeu qualsevol tecla per reiniciar...\n**************************************************\n"
read
sudo reboot
