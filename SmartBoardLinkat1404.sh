#!/bin/bash
# 
# ****************************************************************
# Script d'instal·lació del programari Smartboard per Linkat 14.04
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
zenity --question --title "Instal·lació de Notebook i SmartBoard" --text "Aquest procés instal·la el programari de la pissarra digital SmartBoard i Notebook al vostre $LSBi $LSBr\n\nVoleu continuar?" --width=350 2> /dev/null
#
# Llegim la resposta de l'usuari i la desem en una variable
resposta=$(echo $?);
#
# Si l'usuari ha seleccionat No, obtenim el codi de resposta 1 i per tant no fem cap canvi
if [ "$resposta" == 1 ]; then
	zenity --warning --title "Instal·lació de Notebook i SmartBoard" --text "S'ha abortat el procés d'instal·lació.\nNo s'ha fet cap canvi." --width=350 2> /dev/null;
elif [ "$resposta" == 0 ]; then
#
#Descarrega del paquet de programari per a Smart Board
# Preguntem a l'usuari si vol descarregar el paquet de programari
zenity --question --title "Instal·lació de Notebook i SmartBoard" --text "Voleu descarregar el programari de Smartboard al vostre ordinador?" --width=350 2> /dev/null
#
# Creem la variable de resposta
acceptdwld=$(echo $?);
#
# Si l'usuari no accepta mostrem advertencia i sortim de la instal·lació
if [ "$acceptdwld" == 1 ]; then
zenity --warning --title "Instal·lació de Notebook i SmartBoard" --text "Heu triat no descarregar el programari. Si no heu descarregat al programari anteriorment, aquest procés no podrà continuar." --width=350 2> /dev/null;
# Si l'usuari accepta la instal·lació, continuem
elif [ "$acceptdwld" == 0 ]; then
#
# Actualització de paquets
sudo -S apt-get update | zenity --progress --title "Instal·lació de Notebook i SmartBoard"  --text "Actualitzant el sistema...\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Instal·lació de dependencies necessaries
sudo -S apt-get install dkms patch libcurl3 libnspr4-0d 2> /dev/null ; wget http://es.archive.ubuntu.com/ubuntu/pool/main/u/udev/libudev0_175-0ubuntu9_i386.deb 2> /dev/null ; sudo -S dpkg -i libudev0_175-0ubuntu9_i386.deb 2> /dev/null | zenity --progress --title "Instal·lació de Notebook i SmartBoard" --text "Instal·lant les dependències necessàries...\n" --width=400 --no-cancel --auto-close --pulsate 2> /dev/null;
#
# Descàrrega del programari Smartboard i Notebook
sudo -S wget http://download-linkat.xtec.cat/d83/Linkat_edu_12.04/PDI/SMART/32bits/smart-notebook11-ubuntu-12.04.3-and-linkat-12.04-32bits.tar.gz 2> /dev/null | zenity --progress --title "Instal·lació de Notebook i SmartBoard" --text "Descarregant el programari Smartboard i Notebook.\n\nAixò pot trigar uns minuts. Tingueu paciència...\n" --width=400 --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Descomprimint els fitxers del paquet
sudo -S tar -zxvf ./smart-notebook11-ubuntu-12.04.3-and-linkat-12.04-32bits.tar.gz | zenity --progress --title "Instal·lació de Notebook i SmartBoard" --text "Descomprimint els fitxers necessaris...\n" --width=350 --no-cancel --auto-close --pulsate 2> /dev/null;
else 
zenity --error --title "Instal·lació de Notebook i SmartBoard" --text "S'ha produït un error.\nTorneu a intentar-ho.\n" --width=350 2> /dev/null;
fi
#
# Accedint al directori d'instal·lació
cd smart-notebook11-ubuntu-12.04.3-and-linkat-12.04-32bits
#
# Instal·lar paquets de controladors
zenity --question --title "Instal·lació de Notebook i SmartBoard" --text "Voleu instal·lar els controladors específics de Smartboard al vostre sistema?" --width=350 2> /dev/null
# Preguntem a l'usuari si vol descarregar els controladors
# Creem la variable de resposta
acceptdriversinstall=$(echo $?);
#
# Si l'usuari no accepta, mostrem avis i sortim
if [ "$acceptdriversinstall" == 1 ]; then
zenity --warning --title "Instal·lació de Notebook i SmartBoard" --text "Heu triat no instal·lar els controladors.\n\nSi teniu uns pissarra SmartBoard, el vostre maquinari no funcionarà correctament.\n\nEn cas que vulgueu utilitzar Notebook amb un altre maquinari, algunes funcions poden estar desactivades.\n" --width=350 2> /dev/null;
# Si l'usuari accepta, iniciem la instal·lació de controladors
elif [ "$acceptdriversinstall" == 0 ]; then
(
		echo "5"
		echo "#S'està instal·lant smart-common drivers.\n\n" ; sudo -S dpkg -i ./smart-common_10.3.1236.1-1_i386.deb ; sudo -S apt-get -f install 
		echo "25"
		echo "#S'està instal·lant smart-hwr drivers.\n\n" ; sudo -S dpkg -i ./smart-hwr_11.0.379.1-1_i386.deb ; sudo -S apt-get -f install 
		echo "50"
		echo "#S'està instal·lant smart-language drivers.\n\n" ; sudo -S dpkg -i ./smart-languagesetup_2.2.1191.4-1_i386.deb ; sudo -S apt-get -f install 
		echo "75"
		echo "#S'està instal·lant smart-product drivers.\n\n" ; sudo -S dpkg -i ./smart-product-drivers_11.0.379.1-1_i386.deb ; sudo -S apt-get -f install
		echo "99"
		echo "#S'estan acabant d'instal·lar els controladors necessaris.\n\nEspereu-vos...\n\n"  
		echo "100" ; sleep 1;
		) | zenity --progress --title "Instal·lació de Notebook i SmartBoard" --text "Instal·lant els controladors necessaris.\n" --width=400 --no-cancel --auto-close 2> /dev/null;
# Comprovació si es tracta del model SB480 per instal·lar controladors específics
sb480=$(dpkg -l | grep xserver-xorg-core | grep ii | tr -s " " | cut -f2 -d " ")
case $sb480 in
xserver-xorg-core-lts-quantal)
sudo -S dpkg -i ./sb480/xf86-input-nextwindow/quantal/xf86-input-nextwindow_0.3.4~precise1_i386.deb ; sudo -S dpkg -i ./sb480/nwfermi_0.6.5.0_i386.deb | zenity --progress --title "Instal·lació de Notebook i SmartBoard" --text "Instal·lant els controladors addicionals per al model SB480.\n" --width=400 --no-cancel --auto-close 2> /dev/null; 
;;
xserver-xorg-core-lts-raring)
sudo -S dpkg -i ./sb480/xf86-input-nextwindow/raring/xf86-input-nextwindow_0.3.4~precise3_i386.deb ; sudo -S dpkg -i ./sb480/nwfermi_0.6.5.0_i386.deb | zenity --progress --title "Instal·lació de Notebook i SmartBoard" --text "Instal·lant els controladors addicionals per al model SB480.\n" --width=400 --no-cancel --auto-close 2> /dev/null;
;;
xserver-xorg-core-lts-saucy)
sudo -S ./sb480/xf86-input-nextwindow/saucy/xf86-input-nextwindow_0.3.4~precise4_i386.deb ;sudo -S dpkg -i ./sb480/nwfermi_0.6.5.0_i386.deb | zenity --progress --title "Instal·lació de Notebook i SmartBoard" --text "Instal·lant els controladors addicionals per al model SB480.\n" --width=400 --no-cancel --auto-close 2> /dev/null;
;;
*) 
zenity --info --title "Instal·lació de Notebook i SmartBoard" --text "No es detecta cap PDI del model SB480.\n" --width=400 --auto-close 2> /dev/null;
;;
esac

# Si es produeix un error de selecció d'opció mostrem avis
else 
zenity --error --title "Instal·lació de Notebook i SmartBoard" --text "S'ha produït un error.\nTorneu a intentar-ho." --width=350;
fi
#
# Preguntem a l'usuari si vol instal·lar el programari notebook
zenity --question --title "Instal·lació de Notebook i SmartBoard" --text "Voleu instal·lar el programari Notebook al vostre sistema?" --width=350 2> /dev/null
# Creem la variable de resposta
acceptappinstall=$(echo $?);
#
# Si no accepta mostrem avis i sortim
if [ "$acceptappinstall" == 1 ]; then
zenity --warning --title "Instal·lació de Notebook i SmartBoard" --text "Heu triat no instal·lar el programari Notebook.\n\nAquesta aplicació i les seves funcions no estaran disponibles al vostre $LSBi $LSBr\n" --width=350 2> /dev/null;
# Si accepta iniciem instal·lació
elif [ "$acceptappinstall" == 0 ]; then
(
		echo "5"
		echo "#S'està instal·lant smart-gallery-setup.\n\n" ; sudo -S dpkg -i ./smart-gallerysetup_1.3.1236.1-1_i386.deb ; sudo -S apt-get -f install ; 
		echo "33"
		echo "#S'està instal·lant smart-activation-tool drivers.\n\n" ; sudo -S dpkg -i ./smart-activation_1.1.1181.1-1_i386.deb ; sudo -S apt-get -f install ;
		echo "66"
		echo "#S'està instal·lant smart-notebook.\n\n" ; sudo -S dpkg -i ./smart-notebook_11.0.379.0-1_i386.deb ; sudo -S apt-get -f install ; 
		echo "99"
		echo "#S'està acabant d'instal·lar el programari necessari.\n\nEspereu-vos...\n\n" 
		echo "100"; sleep 1;
		) | zenity --progress --title "Instal·lació de Notebook i SmartBoard" --text "Instal·lant els controladors necessaris.\n" --width=400 --no-cancel --auto-close 2> /dev/null;
# Si es produeix un error de selecció d'opció mostrem avis
else 
zenity --error --title "Instal·lació de Notebook i SmartBoard" --text "S'ha produït un error.\nTorneu a intentar-ho.\n" --width=350;
fi
#
# 
# Eliminant els fitxers de descarrega i instal·lació
sudo -S rm -Rf ../smart-notebook* ../libudev0* | zenity --progress --title "Instal·lació de Notebook i SmartBoard" --text "S'estan eliminant els fitxers temporals de descàrrega...\n" --width=400 --np-cancel --auto-close 2> /dev/null; 
#
# Confirmació dels canvis per pantalla i compte enrere
		(
		echo "0"
		echo "#El vostre equip es reiniciarà d'aquí a 5 segons. Espereu-vos...\n\n" ; sleep 1
		echo "20"
		echo "#El vostre equip es reiniciarà d'aquí a 4 segons. Espereu-vos...\n\n" ; sleep 1
		echo "40"
		echo "#El vostre equip es reiniciarà d'aquí a 3 segons. Espereu-vos...\n\n" ; sleep 1
		echo "60"
		echo "#El vostre equip es reiniciarà d'aquí a 2 segons. Espereu-vos...\n\n" ; sleep 1
		echo "80"
		echo "#El vostre equip es reiniciarà d'aquí a 1 segon. Espereu-vos...\n\n" ; sleep 1
		echo "100"
		) |
		zenity --progress --title "Instal·lació de Notebook i SmartBoard" --percentage=0 --auto-close --width=500 --height=200 --no-cancel 2> /dev/null;
		zenity --info --title "Instal·lació de Notebook i SmartBoard" --text "Aturant el sistema...\n" --width=300 --timeout=3 --auto-close 2> /dev/null;
		# Reiniciem l'equip després de fer els canvis quan hem esgotat el temps d'espera		
		
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
