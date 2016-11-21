#! /bin/bash
# Script d'instal·lació del programari Smartboard per Linkat 12.04
# Copyright JBA 2014
#
#
clear
# Actualització de paquets
echo -e "\n*************************\nActualitzant el sistema...\n*************************\n"
sudo apt-get update
#
# Instal·lació de dependencies necessaries
echo -e "\n*************************\nInstal·lant les dependencies necessaries...\n*************************\n"
sudo apt-get install dkms patch libcurl3 libnspr4-0d
#
#Descarrega del paquet de programari per a Smart Board
echo -e "\n*************************\nDescarregant el programari SmartBoard...\n*************************\n"
wget http://download-linkat.xtec.cat/d83/Linkat_edu_12.04/PDI/SMART/32bits/smart-notebook11-ubuntu-12.04.3-and-linkat-12.04-32bits.tar.gz
#
# Descomprimint els fitxers del paquet
echo -e "\n*************************\nDescomprimint...\n*************************\n"
tar -zxvf smart-notebook11-ubuntu-12.04.3-and-linkat-12.04-32bits.tar.gz
#
# Accedint al directori d'instal·lació
cd smart-notebook11-ubuntu-12.04.3-and-linkat-12.04-32bits
#
# Instal·lar paquets de controladors
echo -e "\n*************************\nInstal·lant els controladors Smart\n*************************\n"
sudo dpkg -i smart-common_10.3.1236.1-1_i386.deb
sudo apt-get -f install
sudo dpkg -i smart-hwr_11.0.379.1-1_i386.deb
sudo apt-get -f install
sudo dpkg -i smart-languagesetup_2.2.1191.4-1_i386.deb
sudo apt-get -f install
sudo dpkg -i smart-product-drivers_11.0.379.1-1_i386.deb 
sudo apt-get -f install
#
# Instal·lar paquets de l'aplicació SmartBoard
echo -e "\n*************************\nInstal·lant el programari SmartBoard...\n*************************\n"
sudo dpkg -i smart-gallerysetup_1.3.1236.1-1_i386.deb
sudo apt-get -f install
sudo dpkg -i smart-activation_1.1.1181.1-1_i386.deb 
sudo apt-get -f install
sudo dpkg -i smart-notebook_11.0.379.0-1_i386.deb 
sudo apt-get -f install
#
# Eliminant els fitxers de descarrega i instal·lació
echo -e "\n*************************\nNetejant els fitxers temporals...\n*************************\n"
sudo rm -Rf smart-notebook11-ubuntu-12.04.3-and-linkat-12.04-32bits.tar.gz
sudo rm -Rf smart-notebook11-ubuntu-12.04.3-and-linkat-12.04-32bits
#
# Reiniciar l'equip per aplicar els canvis
echo -e "\n*************************\nPer aplicar els canvis cal que reinicieu el sistema.\nPremeu qualsevol tecla per reiniciar...\n*************************\n"
read
sudo reboot
