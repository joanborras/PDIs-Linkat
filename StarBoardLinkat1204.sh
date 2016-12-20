#! /bin/bash
# Script d'instal·lació del programari StarBoard per Linkat 12.04
# Copyright JBA 2014
#
#
# Neteja de memòria cau de dpkg
#echo -e "\n**************************************\nNetejant memòria cau d'instal·lació...\n**************************************\n"
sudo rm /var/lib/dpkg/lock
sudo rm -rf /var/cache/apt/archives/*.deb
#
# Ens situem al directori de l'usuari i creem el directori de descàrrega i instal·lació.
cd ~
sudo mkdir SBS0943_LINUX
cd SBS0943_LINUX
#
# Descarrega del paquet de programari StarBoard
echo -e "\n***************************************\nDescarregant el programari StarBoard...\n***************************************\n"
wget www.charmexdocs.com/int/software/SBS0943_LINUX.zip
#
# Descomprimint els fitxers del paquet
echo -e "\n****************\nDescomprimint...\n****************\n"
sudo unzip SBS0943_LINUX.zip 
#
# Accedint al directori d'instal·lació
cd StarBoardSoftware
#
# Instal·lar el programari
sudo dpkg -i StarBoardSoftware_9*.deb 
#
# Eliminant els fitxers de descarrega i instal·lació
echo -e "\n*********************************\nNetejant els fitxers temporals...\n*********************************\n"
cd ~
sudo rm -Rf SBS0943_LINUX
sudo rm -Rf StarBoardLinkat1204.sh
#
# Reiniciar l'equip per aplicar els canvis
echo -e "\n****************************************************\nPer aplicar els canvis cal que reinicieu el sistema.\nPremeu qualsevol tecla per reiniciar...\n****************************************************\n"
read
sudo reboot
