#!/bin/bash
# 
# ****************************************************************
# Script d'instal·lació del programari Promethean per Linkat 14.04
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
zenity --question --title "Instal·lació de Promethean i Active Inspire" --text "Aquest procés instal·la el programari de la pissarra digital Promethean i Active Inspire al vostre $LSBi $LSBr\n\nVoleu continuar?" --width=350 2> /dev/null
#
# Llegim la resposta de l'usuari i la desem en una variable
resposta=$(echo $?);
#
# Si l'usuari ha seleccionat No, obtenim el codi de resposta 1 i per tant no fem cap canvi
if [ "$resposta" == 1 ]; then
	zenity --warning --title "Instal·lació de Promethean i Active Inspire" --text "S'ha abortat el procés d'instal·lació.\nNo s'ha fet cap canvi." --width=350 2> /dev/null;
elif [ "$resposta" == 0 ]; then
#
#Descarrega del paquet de programari per a Smart Board
# Preguntem a l'usuari si vol descarregar el paquet de programari
zenity --question --title "Instal·lació de Promethean i Active Inspire" --text "Voleu descarregar el programari de Promethean al vostre ordinador?" --width=350 2> /dev/null
#
# Creem la variable de resposta
acceptdwld=$(echo $?);
#
# Si l'usuari no accepta mostrem advertencia i sortim de la instal·lació
if [ "$acceptdwld" == 1 ]; then
zenity --warning --title "Instal·lació de Promethean i Active Inspire" --text "Heu triat no descarregar el programari. Si no heu descarregat al programari anteriorment, aquest procés no podrà continuar." --width=350 2> /dev/null;
# Si l'usuari accepta la instal·lació, continuem
elif [ "$acceptdwld" == 0 ]; then
#
# Operacions prèvies a la instal·lació
case $LSBr in
12.04)
# Afegint els repositoris de Promethean
sudo -S add-apt-repository 'deb http://activsoftware.co.uk/linux/repos/ubuntu precise oss non-oss' | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nAfegint el repositori de Promethean...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Descarregant el certificat de Promethean
sudo -S wget http://www.activsoftware.co.uk/linux/repos/Promethean.asc | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nDescarregant el certificat...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Instal·lant el certificat de Promethean
sudo -S apt-key add Promethean.asc | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nDescarregant el certificat...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Instal·lació de dependencies necessaries
sudo -S wget http://es.archive.ubuntu.com/ubuntu/pool/main/u/udev/libudev0_175-0ubuntu9_i386.deb ; sudo -S dpkg -i libudev0_175-0ubuntu9_i386.deb | zenity --progress --title "Instal·lació de Promethean i Active Inspire" --text "Instal·lant les dependències necessàries...\n" --width=400 --no-cancel --auto-close --pulsate 2> /dev/null;
#
# Actualització de paquets
sudo -S apt-get update 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "Actualitzant el sistema...\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null;
# 
# Instal·lació del programari de la PDI
(
		echo "5"
		echo "#S'està instal·lant active-meta-ca\n\n" ; sudo -S apt-get install -y activ-meta-ca ; 
		echo "30"
		echo "#S'està instal·lant activaid\n\n" ; apt-get install -y activaid ;
		echo "40"
		echo "#S'està instal·lant activdriver\n\n" ; sudo -S apt-get install -y activdriver ; 
		echo "50"
		echo "#S'està instal·lant activinspire\n\n" ; sudo -S apt-get install -y activinspire ;
		echo "60"
		echo "#S'està instal·lant activinspire-help-ca\n\n" ; sudo -S apt-get install -y activinspire-help-ca ;
		echo "70"
		echo "#S'està instal·lant activresources-core-ca\n\n" ; sudo -S apt-get install -y activresources-core-ca ;
		echo "80"
		echo "#S'està instal·lant activtools\n\n" ; sudo -S apt-get install -y  activtools ;
		echo "90"
		echo "#S'està instal·lant libjpeg62\n\n" ; sudo -S apt-get install -y libjpeg62 ;
		echo "95"
		echo "#S'està instal·lant libssl0.9.8\n\n" ; sudo -S apt-get install -y libssl0.9.8 ;
		echo "99"
		echo "#S'estan acabant d'instal·lar els controladors necessaris.\n\nEspereu-vos...\n\n"  
		echo "100" ; sleep 1;
		) | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'està instal·lant el programari de la PDI.\nAixò pot trigar una estona. Tingueu paciència...\n" --width=400  --no-cancel --auto-close  2> /dev/null; 
#
# Habilitar el reconeixement d'escriptura en català
( 
		echo "5"
		echo "#S'està instal·lant activhwr-ca\n\n" ; sudo apt-get install -y activhwr-ca ;
		echo "99"
		echo "#S'estan acabant d'instal·lar els controladors necessaris.\n\nEspereu-vos...\n\n"  
		echo "100" ; sleep 1;
		) | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'està instal·lant el mòdul de reconeixement d'escriptura en català...\n" --width=400  --no-cancel --auto-close 2> /dev/null;
#
# Eliminant els fitxers de descarrega i instal·lació
sudo -S rm -Rf ./Promethean.asc* ./libudev0* | zenity --progress --title "Promethean i Active Inspire" --text "S'estan eliminant els fitxers temporals de descàrrega...\n" --width=400 --np-cancel --auto-close 2> /dev/null; 
#
;;
14.04)
# Afegint els repositoris de Promethean
sudo -S add-apt-repository 'deb http://activsoftware.co.uk/linux/repos/ubuntu trusty oss non-oss' | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nAfegint el repositori de Promethean...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Descarregant el certificat de Promethean
sudo -S wget http://www.activsoftware.co.uk/linux/repos/Promethean.asc | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nDescarregant el certificat...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Instal·lant el certificat de Promethean
sudo -S apt-key add Promethean.asc | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nDescarregant el certificat...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Instal·lació de dependencies necessaries
sudo -S wget http://es.archive.ubuntu.com/ubuntu/pool/main/u/udev/libudev0_175-0ubuntu9_i386.deb ; sudo -S dpkg -i libudev0_175-0ubuntu9_i386.deb | zenity --progress --title "Instal·lació de Promethean i Active Inspire" --text "Instal·lant les dependències necessàries...\n" --width=400 --no-cancel --auto-close --pulsate 2> /dev/null;
#
# Actualització de paquets
sudo -S apt-get update 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "Actualitzant el sistema...\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null;
# 
# Instal·lació del programari de la PDI
(
		echo "5"
		echo "#S'està instal·lant active-meta-ca\n\n" ; sudo -S apt-get install -y activ-meta-ca ; 
		echo "30"
		echo "#S'està instal·lant activaid\n\n" ; apt-get install -y activaid ;
		echo "40"
		echo "#S'està instal·lant activdriver\n\n" ; sudo -S apt-get install -y activdriver ; 
		echo "50"
		echo "#S'està instal·lant activinspire\n\n" ; sudo -S apt-get install -y activinspire ;
		echo "60"
		echo "#S'està instal·lant activinspire-help-ca\n\n" ; sudo -S apt-get install -y activinspire-help-ca ;
		echo "70"
		echo "#S'està instal·lant activresources-core-ca\n\n" ; sudo -S apt-get install -y activresources-core-ca ;
		echo "80"
		echo "#S'està instal·lant activtools\n\n" ; sudo -S apt-get install -y  activtools ;
		echo "90"
		echo "#S'està instal·lant libjpeg62\n\n" ; sudo -S apt-get install -y libjpeg62 ;
		echo "95"
		echo "#S'està instal·lant libssl0.9.8\n\n" ; sudo -S apt-get install -y libssl0.9.8 ;
		echo "99"
		echo "#S'estan acabant d'instal·lar els controladors necessaris.\n\nEspereu-vos...\n\n"  
		echo "100" ; sleep 1;
		) | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'està instal·lant el programari de la PDI.\nAixò pot trigar una estona. Tingueu paciència...\n" --width=400  --no-cancel --auto-close  2> /dev/null; 
#
# Habilitar el reconeixement d'escriptura en català
( 
		echo "5"
		echo "#S'està instal·lant activhwr-ca\n\n" ; sudo apt-get install -y activhwr-ca ;
		echo "99"
		echo "#S'estan acabant d'instal·lar els controladors necessaris.\n\nEspereu-vos...\n\n"  
		echo "100" ; sleep 1;
		) | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'està instal·lant el mòdul de reconeixement d'escriptura en català...\n" --width=400  --no-cancel --auto-close 2> /dev/null;
#
# Eliminant els fitxers de descarrega i instal·lació
sudo -S rm -Rf ./Promethean.asc* ./libudev0* | zenity --progress --title "Instal·lació de Promethean i Active Inspire" --text "S'estan eliminant els fitxers temporals de descàrrega...\n" --width=400 --no-cancel --auto-close 2> /dev/null; 
#
;;
#
#
16.04)
# En funció de l'arquitectura caldrà instal·lar un o altre paquet
# Comprovem l'arquitectura del sistema amb una variable que hi fa referencia
ARCHT=$(uname -m)
case $ARCHT in
#
# Si el sistema es de 32 bits
i686)
#
# Descarreguen el paquet adient per a l'arquitectura de 32 bits
sudo -S wget https://www.dropbox.com/s/axy4fgukg4y9c46/Promethean_Driver_32bits-xenial.tar 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire" --text "S'està descarregant el paquet de controladors...\n" --width=400 --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Donem permisos per a l'execució del fitxer
sudo -S chmod 755 Promethean_Driver_32bits-xenial.tar
# Descomprimim el fitxer en un altre directori
sudo -S mkdir ./Promethean_Driver 2> /dev/null
# Descomprimim
sudo -S tar -xvf Promethean_Driver_32bits-xenial.tar -C ./Promethean_Driver | zenity --progress --title "Instal·lació de Promethean i Active Inspire" --text "S'estan descomprimint els fitxers...\n" --width=400 --no-cancel --auto-close --pulsate 2> /dev/null; 
# Instal·lem els paquets de controladors
(
		echo "5"
		echo "#S'està instal·lant activaid\n\n" ; sudo -S dpkg -i ./Promethean_Driver/activaid*.deb 2> /dev/null; 
		echo "25"
		echo "#S'està instal·lant activdriver\n\n" ; sudo -S dpkg -i ./Promethean_Driver/activdriver*.deb 2> /dev/null ; 
		echo "50"
		echo "#S'està instal·lant activtools\n\n" ; sudo -S dpkg -i ./Promethean_Driver/activtools*.deb 2> /dev/null ; 
		echo "75"
		echo "#S'està instal·lant ActivRelay\n\n" ; sudo -S dpkg -i ./Promethean_Driver/ActivRelay*.deb 2> /dev/null ; 
		echo "99" 
		echo "#S'estan acabant d'instal·lar els controladors necessaris.\n\nEspereu-vos...\n\n"  
		echo "100" ; sleep 1;
		) | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan instal·lant els controladors de la PDI.\nAixò pot trigar una estona. Tingueu paciència...\n" --width=400  --no-cancel --auto-close  2> /dev/null; 
sudo -S apt-get install -f -y 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'està actualitzant el sistema. Això pot trigar una estona. Tingueu paciència...\n" --width=400  --no-cancel --auto-close  2> /dev/null; 
# Instal·lar paquets addicionals i dependències necessaries
wget http://archive.ubuntu.com/ubuntu/pool/universe/o/openssl098/libssl0.9.8_0.9.8o-7ubuntu3.2.14.04.1_i386.deb
sudo -S dpkg -i ./libssl0.9.8_0.9.8o-7ubuntu3.2.14.04.1_i386.deb  2> /dev/null ; sudo -S apt-get install -y module-assistant 2> /dev/null ; sudo -S apt-get -y install libnss3-tools gamin libgamin0 libnss3-tools libxdo3 xdotool 2> /dev/null ; sudo -S apt-get -f install 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan instal·lant paquets addicionals i altres dependències...\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
# Reparar enllaços simbòlics
sudo -S ln -s /usr/local/lib /usr/local/lib32 2> /dev/null; sleep 2 | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan reparant els enllaços del sistema...\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
#
# Instal·lem els paquets de Active Inspire
#
# Descarregant el certificat de Promethean
sudo -S wget http://www.activsoftware.co.uk/linux/repos/Promethean.asc 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nDescarregant el certificat...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Instal·lant el certificat de Promethean
sudo -S apt-key add Promethean.asc 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nDescarregant el certificat...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Afegint els repositoris de Promethean
sudo -S add-apt-repository 'deb http://activsoftware.co.uk/linux/repos/ubuntu precise oss non-oss' 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nAfegint el repositori de Promethean...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Preparant la instal·lació
(
		echo "5"
		echo "#S'estan instal·lant les biblioteques necessàries.\n\n" ;  #sudo -S echo "deb http://old-releases.ubuntu.com/ubuntu/ raring main restricted universe multiverse" > /etc/apt/sources.list.d/ia32-libs-raring.list; sudo -S apt-get update; sudo -S apt-get install ia32-libs; sudo -S mkdir /usr/local/lib32; sudo ln -s /usr/lib/i386-linux-gnu/libjpeg.so.8.0.2 /usr/local/lib32/libjpeg.so.62;
sudo -S apt-get install -y gcc-multilib ;
		echo "50" 
		echo "#S'està instal·lant el programari Active Inspire\n\n" ; sudo -S apt-get install -y activinspire 2> /dev/null ; sudo -S apt-get install -f 2> /dev/null;
		echo "99" 
		echo "#S'està acabant d'instal·lar el programari.\n\nEspereu-vos...\n\n"  
		echo "100" ; sleep 1;
		) | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan instal·lant el programari Active Inspire.\nAixò pot trigar una estona. Tingueu paciència...\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
# Eliminant els fitxers de descarrega i instal·lació
sudo -S add-apt-repository --remove 'deb http://activsoftware.co.uk/linux/repos/ubuntu trusty oss non-oss' 2> /dev/null ; sudo -S rm -Rf ./Promethean_Driver* Promethean.asc* 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire" --text "S'estan eliminant els fitxers temporals d'instal·lació...\n" --width=400 --no-cancel --auto-close 2> /dev/null; 
#
;;
#
# Si el sistema es de 64 bits
x86_64)
#
# Descarreguen el paquet adient per a l'arquitectura de 32 bits
sudo -S wget https://www.dropbox.com/s/lfgsnwdiytzha0q/Promethean_Driver_64bits-xenial.tar 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire" --text "S'està descarregant el paquet de controladors...\n" --width=400 --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Donem permisos per a l'execució del fitxer
sudo -S chmod 755 Promethean_Driver_64bits-xenial.tar
# Descomprimim el fitxer en un altre directori
sudo -S mkdir ./Promethean_Driver 2> /dev/null
# Descomprimim
sudo -S tar -xvf Promethean_Driver_64bits-xenial.tar -C ./Promethean_Driver | zenity --progress --title "Instal·lació de Promethean i Active Inspire" --text "S'estan descomprimint els fitxers...\n" --width=400 --no-cancel --auto-close --pulsate 2> /dev/null; 
# Instal·lem els paquets de controladors
(
		echo "5"
		echo "#S'està instal·lant activaid\n\n" ; sudo -S dpkg -i ./Promethean_Driver/activaid*.deb 2> /dev/null; 
		echo "25"
		echo "#S'està instal·lant activdriver\n\n" ; sudo -S apt-get install dkms; sudo -S dpkg -i ./Promethean_Driver/activdriver*.deb 2> /dev/null ; 
		echo "50"
		echo "#S'està instal·lant activtools\n\n" ; sudo -S dpkg -i ./Promethean_Driver/activtools*.deb; sudo apt-get -f install 2> /dev/null ; 
		echo "75"
		echo "#S'està instal·lant ActivRelay\n\n" ; sudo -S dpkg -i ./Promethean_Driver/ActivRelay*.deb; sudo apt-get -f install 2> /dev/null ; 
		echo "99" 
		echo "#S'estan acabant d'instal·lar els controladors necessaris.\n\nEspereu-vos...\n\n"  
		echo "100" ; sleep 1;
		) | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan instal·lant els controladors de la PDI.\nAixò pot trigar una estona. Tingueu paciència...\n" --width=400  --no-cancel --auto-close  2> /dev/null; 
sudo -S apt-get install -f -y 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'està actualitzant el sistema. Això pot trigar una estona. Tingueu paciència...\n" --width=400  --no-cancel --auto-close  2> /dev/null; 
# Reparar enllaços simbòlics
cd /usr/local/lib/ && sudo -S ln -s libactivboardex.so.1.0 libactivboardex.so.1;
sudo -S ln -s /usr/local/lib /usr/local/lib32 2> /dev/null; sleep 2 | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan reparant els enllaços del sistema...\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
#
# Instal·lem els paquets de Active Inspire
#
# Descarregant el certificat de Promethean
sudo -S wget http://www.activsoftware.co.uk/linux/repos/Promethean.asc 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nDescarregant el certificat...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Instal·lant el certificat de Promethean
sudo -S apt-key add Promethean.asc 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nDescarregant el certificat...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Afegint els repositoris de Promethean
sudo -S add-apt-repository 'deb http://activsoftware.co.uk/linux/repos/ubuntu trusty oss non-oss' 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan realitzant les operacions prèvies a la instal·lació.\nAfegint el repositori de Promethean...\n\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
#
# Preparant la instal·lació
(
		echo "5"
		echo "#S'estan instal·lant les biblioteques necessàries.\n\n" ; sudo -S apt-get install -y gcc-multilib ;
		echo "50" 
		echo "#S'està instal·lant el programari Active Inspire\n\n" ; sudo -S apt-get install -y activinspire 2> /dev/null ; sudo -S apt-get install -f 2> /dev/null;
		echo "99" 
		echo "#S'està acabant d'instal·lar el programari.\n\nEspereu-vos...\n\n"  
		echo "100" ; sleep 1;
		) | zenity --progress --title "Instal·lació de Promethean i Active Inspire"  --text "S'estan instal·lant el programari Active Inspire.\nAixò pot trigar una estona. Tingueu paciència...\n" --width=400  --no-cancel --auto-close --pulsate 2> /dev/null; 
# Eliminant els fitxers de descarrega i instal·lació
sudo -S add-apt-repository --remove 'deb http://activsoftware.co.uk/linux/repos/ubuntu trusty oss non-oss' 2> /dev/null ; sudo -S rm -Rf ./Promethean_Driver* Promethean.asc* 2> /dev/null | zenity --progress --title "Instal·lació de Promethean i Active Inspire" --text "S'estan eliminant els fitxers temporals d'instal·lació...\n" --width=400 --no-cancel --auto-close 2> /dev/null; 
#
;;
#
esac

;;
*)
zenity --error --title "Instal·lació de Promethean i Active Inspire"  --text "No s'ha pogut trobar un repositori adient a la vostra versió de Ubuntu.\n" --width=400 --ok-label=Sortir 2> /dev/null; 
exit 
;;
esac
#
# Si es produeix un error de selecció d'opció mostrem avis
else 
zenity --error --title "Instal·lació de Promethean i Active Inspire" --text "S'ha produït un error.\nTorneu a intentar-ho.\n" --width=350 2> /dev/null;
fi

# Reiniciem l'equip després de fer els canvis quan hem esgotat el temps d'espera		
		
sudo reboot

else
# En cas que es produeixi un error en la selecció de l'usuari i s'obtingui un codi diferent de 0 o 1 mostrem un missatge d'error.
zenity --error --title "Instal·lació de Promethean i Active Inspire" --text "S'ha produït un error.\nTorneu a intentar-ho.\n" --width=350;
fi
}
else
# Si l'usuari que ha executat el script no és root mostrem advertencia i tanquem el procés
	zenity --warning --text "No teniu privilegis suficients per executar aquest programa.\nProveu d'executar ek programa com a super-usuari." --title="Instal·lació de Promethean i Active Inspire\n" --width=350;
	exit 1
fi
