#!/bin/bash
# 
# ****************************************************************
# Script d'instal·lació del programari InterWrite per Linkat 14.04
# Copyright JBA 2016
# ****************************************************************
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
zenity --question --title "Instal·lació de InterWrite i eInstruction" --text "Aquest procés instal·la el programari de la pissarra digital InterWrite i eInstruction al vostre $LSBi $LSBr\n\nVoleu continuar?" --width=350 2> /dev/null
#
# Llegim la resposta de l'usuari i la desem en una variable
resposta=$(echo $?);
#
# Si l'usuari ha seleccionat No, obtenim el codi de resposta 1 i per tant no fem cap canvi
if [ "$resposta" == 1 ]; then
	zenity --warning --title "Instal·lació de InterWrite i eInstruction" --text "S'ha abortat el procés d'instal·lació.\nNo s'ha fet cap canvi." --width=350 2> /dev/null;
elif [ "$resposta" == 0 ]; then
#
#Descarrega del paquet de programari per a InterWrite
# Preguntem a l'usuari si vol descarregar el paquet de programari
zenity --question --title "Instal·lació de InterWrite i eInstruction" --text "Voleu descarregar el programari InterWrite i eInstruction al vostre ordinador?" --width=350 2> /dev/null
#
# Creem la variable de resposta
acceptdwld=$(echo $?);
#
# Si l'usuari no accepta mostrem advertencia i sortim de la instal·lació
if [ "$acceptdwld" == 1 ]; then
zenity --warning --title "Instal·lació de InterWrite i eInstruction" --text "Heu triat no descarregar el programari. Si no heu descarregat al programari anteriorment, aquest procés no podrà continuar." --width=350 2> /dev/null;
# Si l'usuari accepta la instal·lació, continuem
elif [ "$acceptdwld" == 0 ]; then
#
# Operacions prèvies a la instal·lació
# Creem el directori de descàrrega i instal·lació.
if [ ! -d ./InterWrite/ ]; then sudo -S mkdir ./InterWrite/ | zenity --progress --title "Instal·lació de InterWrite i eInstruction"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nCreant l'estructura del directori de descàrrega i instal·lació...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; fi
#
# Descarrega del paquet de programari StarBoard
cd ./InterWrite; sudo -S wget legacy.einstruction.com/support_downloads/files/linux/Workspace_Linux_6.1.54.71415.zip ./Interwrite/ | zenity --progress --title "Instal·lació de InterWrite i eInstruction"  --text "S'está descarregant el paquet d'instal·lació...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Creant un enllaç simbòlic a les llibreries
case $LSBr in
12.04)
if [ ! -f /lib/libc.so.6 ]; then sudo -S ln -s /lib/i386-linux-gnu/libc-2.15.so /lib/libc.so.6 | zenity --progress --title "Instal·lació de InterWrite i eInstruction"  --text "S'estan creant enllaços simbòlics...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; fi
;;
14.04)
if [ ! -f /lib/libc.so.6 ]; then sudo -S ln -s /lib/x86_64-linux-gnu/libc.so.6 /lib/libc.so.6 | zenity --progress --title "Instal·lació de InterWrite i eInstruction"  --text "S'estan creant enllaços simbòlics...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; fi
;;
16.04)
if [ ! -f /lib/libc.so.6 ]; then sudo -S ln -s /lib/x86_64-linux-gnu/libc.so.6 /lib/libc.so.6 | zenity --progress --title "Instal·lació de InterWrite i eInstruction"  --text "S'estan creant enllaços simbòlics...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; fi
;;
esac
#
# Descomprimint els fitxers del paquet
sudo -S unzip Workspace_Linux_6.1.54.71415.zip | zenity --progress --title "Instal·lació de InterWrite i eInstruction"  --text "S'estan descomprimint els fitxers del paquet d'instal·lació...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Preparant el directori d'instal·lació de Workspace
sudo -S mkdir -p /opt/eInstruction/Workspace ; sudo chmod 777 -R /opt/eInstruction | zenity --progress --title "Instal·lació de InterWrite i eInstruction"  --text "S'està preparant el directori d'instal·lació...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Instal·lar el programari
sudo -S chmod +x Workspace_Installer.bin | zenity --info --title "Instal·lació de InterWrite i eInstruction"  --text "Tot seguit s'iniciarà l'assistnt per a la instal·lació del programari...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; sudo -S $PWD/Workspace_Installer.bin
#
# Eliminant els fitxers temporals de descàrrega i instal·lació
sudo -S rm -Rf ./InterWrite | zenity --info --title "Instal·lació de InterWrite i eInstruction"  --text "S'estan eliminant els fitxers temporals d'instal·lació...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Si es produeix un error de selecció d'opció mostrem avis
else 
zenity --error --title "Instal·lació de InterWrite i eInstruction" --text "S'ha produït un error.\nTorneu a intentar-ho.\n" --width=350 2> /dev/null;
fi
#
# Reiniciem l'equip després de fer els canvis quan hem esgotat el temps d'espera		
		
sudo reboot

else
# En cas que es produeixi un error en la selecció de l'usuari i s'obtingui un codi diferent de 0 o 1 mostrem un missatge d'error.
zenity --error --title "Instal·lació de InterWrite i eInstruction" --text "S'ha produït un error.\nTorneu a intentar-ho.\n" --width=350;
fi
}
else
# Si l'usuari que ha executat el script no és root mostrem advertencia i tanquem el procés
	zenity --warning --text "No teniu privilegis suficients per executar aquest programa.\nProveu d'executar ek programa com a super-usuari." --title="Instal·lació de InterWrite i eInstruction\n" --width=350;
	exit 1
fi
