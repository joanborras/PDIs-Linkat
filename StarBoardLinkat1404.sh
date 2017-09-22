#!/bin/bash
# 
# *******************************************************************************
# Script d'instal·lació del programari per a Hitachi StarBoard per a Linkat 14.04
# Copyright JBA 2017
# *******************************************************************************
#
# Comprovem que l'script s'executa com a root
if [ -n "$(id | grep root)" ]; then
{
# En cas afirmatiu continuem el procés
xhost +
clear
#
# Determinem la versió d'Ubuntu en execució amb filtre de nom i versió eliminant espais en blanc
LSBi=$(lsb_release -i | cut -d: -f2 |tr -d '[[:space:]]')
LSBr=$(lsb_release -r | cut -d: -f2 |tr -d '[[:space:]]')
#
# Iniciem el programa d'instal·lació i demanem el consentiment de l'usuari
zenity --question --title "Instal·lació de Hitachi StarBoard" --text "Aquest procés instal·la el programari de la pissarra digital Hitachi StarBoard al vostre $LSBi $LSBr\n\nVoleu continuar?" --width=350 2> /dev/null
#
# Llegim la resposta de l'usuari i la desem en una variable
resposta=$(echo $?);
#
# Si l'usuari ha seleccionat No, obtenim el codi de resposta 1 i per tant no fem cap canvi
if [ "$resposta" == 1 ]; then
	zenity --warning --title "Instal·lació de Hitachi StarBoard" --text "S'ha abortat el procés d'instal·lació.\nNo s'ha fet cap canvi." --width=350 2> /dev/null;
elif [ "$resposta" == 0 ]; then
#
# Actualització de paquets
sudo -S apt-get update | zenity --progress --title "Instal·lació de Hitachi StarBoard"  --text "Actualitzant el sistema...\nAixò pot trigar una estona.\nEspereu-vos..." --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; sudo -S apt-get upgrade -y | zenity --progress --title "Instal·lació de Hitachi StarBoard"  --text "Actualitzant el sistema...\nAixò pot trigar una estona.\nEspereu-vos..." --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Neteja de memòria cau de dpkg
sudo rm /var/lib/dpkg/lock; sudo rm -rf /var/cache/apt/archives/*.deb | zenity --progress --title "Instal·lació de Hitachi StarBoard" --text "S'està netejant la memòria cau d'instal·lació." --width=350 --no-cancel --auto-close --pulsate 2> /dev/null;

#
# Ens situem al directori de l'usuari i creem el directori de descàrrega.
cd ~; sudo -S mkdir ./StarBoard_LINUX; cd ./Starboard_LINUX
#
# Descarrega del paquet de programari StarBoard
case $LSBr in
12.04)
sudo -S wget www.charmexdocs.com/int/software/SBS0943_LINUX.zip
;;
14.04)
sudo -S wget www.charmexdocs.com/int/software/SBS0962_LINUX.zip
;;
16.04)
sudo -S wget www.charmexdocs.com/int/software/SBS0962_LINUX.zip
;;
esac | zenity --progress --title "Instal·lació de Hitachi StarBoard" --text "Descarregant els fitxers d'instal·lació." --width=350 --no-cancel --auto-close --pulsate 2> /dev/null;
# Descomprimint els fitxers del paquet
sudo unzip SBS09*_LINUX.zip | zenity --progress --title "Instal·lació de Hitachi StarBoard" --text "S'estant descomprimint els fitxers de la descàrrega." --width=350 --no-cancel --auto-close --pulsate 2> /dev/null;
#
# Accedint al directori d'instal·lació i Instal·lar el programari
cd ./SBS09*/StarBoardSoftware; sudo dpkg -i StarBoardSoftware_9*.deb | zenity --progress --title "Instal·lació de Hitachi StarBoard" --text "S'està instal·lant el programari StarBoard." --width=350 --no-cancel --auto-close --pulsate 2> /dev/null;
#
# Configurant el programari
sudo -S /usr/local/StarBoardSoftware/install.sh | zenity --progress --title "Instal·lació de Hitachi StarBoard" --text "S'està instal·lant el programari StarBoard." --width=350 --no-cancel --auto-close --pulsate 2> /dev/null;
# Eliminant els fitxers de descarrega i instal·lació
cd ~; sudo -S rm -Rf StarBoard*; sudo -S rm -Rf StarBoardLinkat1*.sh | zenity --progress --title "Instal·lació de Hitachi StarBoard" --text "Netejant els fitxers temporals d'instal·lació." --width=350 --no-cancel --auto-close --pulsate 2> /dev/null;
#
# Reiniciar l'equip per aplicar els canvis
echo -e "\n****************************************************\nPer aplicar els canvis cal que reinicieu el sistema.\nPremeu qualsevol tecla per reiniciar...\n****************************************************\n"
read
sudo reboot
else
# En cas que es produeixi un error en la selecció de l'usuari i s'obtingui un codi diferent de 0 o 1 mostrem un missatge d'error.
zenity --error --title "Instal·lació de Notebook i SmartBoard" --text "S'ha produït un error.\nTorneu a intentar-ho.\n" --width=350;
fi
}
else
# Si l'usuari que ha executat el script no és root mostrem advertencia i tanquem el procés
	zenity --warning --text "No teniu privilegis suficients per executar aquest programa.\nProveu d'executar ek programa com a super-usuari." --title="Instal·lació de Notebook i SmartBoard\n" --width=350;
	exit 1
fi

