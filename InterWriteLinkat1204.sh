#! /bin/bash
# Script d'instal·lació del programari InterWrite per Linkat 12.04
# Copyright JBA 2014
#
#
# Ens situem al directori de l'usuari i creem el directori de descàrrega i instal·lació.
cd ~
sudo mkdir InterWrite
cd InterWrite
#
# Descarrega del paquet de programari StarBoard
echo -e "\n****************************************\nDescarregant el programari InterWrite...\n****************************************\n"
wget legacy.einstruction.com/support_downloads/files/linux/Workspace_Linux_6.1.54.71415.zip
#
# Creant un enllaç simbòlic a les llibreries
sudo ln -s /lib/i386-linux-gnu/libc-2.15.so /lib/libc.so.6
#
# Descomprimint els fitxers del paquet
echo -e "\n****************\nDescomprimint...\n****************\n"
sudo unzip Workspace_Linux_6.1.54.71415.zip
#
# Preparant el directori d'instal·lació de Workspace
sudo mkdir -p /opt/eInstruction/Workspace
sudo chmod 777 -R /opt/eInstruction
#
# Instal·lar el programari
echo -e "\n****************************\nInstal·lant el programari...\n****************************\n"
sudo chmod +x Workspace_Installer
sudo ./Workspace_Installer
#
# Eliminant els fitxers de descarrega i instal·lació
echo -e "\n*********************************\nNetejant els fitxers temporals...\n*********************************\n"
cd ~
sudo rm -Rf InterWrite
#sudo rm -Rf InterWriteLinkat1204.sh
#
# Reiniciar l'equip per aplicar els canvis
echo -e "\n****************************************************\nPer aplicar els canvis cal que reinicieu el sistema.\nPremeu qualsevol tecla per reiniciar...\n****************************************************\n"
read
sudo reboot
