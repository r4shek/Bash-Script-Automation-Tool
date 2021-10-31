#!/bin/bash

#Funcion para ir llamando a los diferentes mensajes del script
Mensajes(){
	if [ $# -eq 1 ]
	then
		mensaje=$1
		case $mensaje in
			0)
				echo
				echo "Arrancando Metasploit... exit para volver al menu"
				echo
				;;
			1)
				echo
				echo "Arrancando Dirbuster... exit para volver al menu"
				echo
				;;
			2)
				echo
				echo -n "Introduce una direccion IP:"
				;;
			3)
				echo
				echo -n "Introduce un puerto o un rango de puertos, ej. 80; ej2. 20-500:"
				;;
			4)
				echo
				echo -n "Introduce un puerto:"
				;;
			6)
				echo
				echo "Saliendo..."
				echo
				;;
			*)
				;;
		esac
	else
		echo "error en los argumentos"
	fi
}

#Funcion para leer IP y puertos
Leer(){
	read var
	echo $var
}


#Comprueba que no se han pasado argumentos
if [ $# -eq 0 ]
then
	salida=0
	#Bucle para iterar el menu
	while [ $salida -ne 6 ]
	do
		echo
		echo "  __ _ _   _| |_ ___   | |_ ___   ___ | |___  "
		echo " / _  | | | | __/ _ \  | __/ _ \ / _ \| / __| "
		echo "| (_| | |_| | || (_) | | || (_) | (_) | \__ \ "
		echo " \__ _|\__,_|\__\___/   \__\___/ \___/|_|___/ "
		echo
		echo "1) Metasploit"
		echo "2) Dirbuster"
		echo "3) Nmap"
		echo "4) Ofrecer Shell a traves de Netcat en un puerto"
		echo "5) Conectar con una Shell remota a traves de Netcat"
		echo "6) Salir"
		echo
		echo -n "Introduce opcion:"
		read opcion

		case $opcion in
			1)
				Mensajes 0
				msfconsole
				;;
			2)
				Mensajes 1
				dirbuster
				;;
			3)
				Mensajes 2
				ip=$(Leer)
				Mensajes 3
				puerto=$(Leer)
				nmap -p $puerto -sS $ip
				;;
			4)
				Mensajes 4
				puerto=$(Leer)
				nc -lvp $puerto
				;;
			5)
				Mensajes 2
				ip=$(Leer)
				Mensajes 4
				puerto=$(Leer)
				nc -nv $ip $puerto
				;;
			6)
				Mensajes 6
				salida=6
				;;
			*)
				;;
		esac
	done
else
	echo "Usage: $0"
fi