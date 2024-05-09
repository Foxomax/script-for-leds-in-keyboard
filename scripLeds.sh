#!/bin/bash

caracterAnimation="\ | /"
location=""

# Función para buscar el archivo
findArchive() {
    if find /sys/class/leds/input0::scrolllock -name "input8::scrolllock" >/dev/null 2>&1; then
        location="/sys/class/leds/input4::scrolllock"
    elif find /sys/class/leds/input17::scrolllock -name "input17::scrolllock" >/dev/null 2>&1; then
        location="/sys/class/leds/input17::scrolllock"
    elif find /sys/class/leds/input19::scrolllock -name "input19::scrolllock" >/dev/null 2>&1; then
        location="/sys/class/leds/input19::scrolllock"
    else
        echo "It was not found on any of the common routes. You must do it manually,"
        echo "go to: /sys/class/leds and look for a file that contains 'scrolllock'."
	echo "Escribe la ruta: "
	read auxiliarRoute
        return 1
    fi
    echo "Script funcionando.."
    return 0
}

# Función para cargar la animación
loadAnimation() {
    contador=0
    while [ $contador -lt 10 ]; do
        for caracter in ${caracterAnimation}; do
            echo -ne "\r${caracter}"
            sleep 0.2
        done
        contador=$((contador + 1))
    done
}

echo "Buscando las rutas comunes..."
loadAnimation
echo -ne "\r "
echo -e "\n"

# Llamada a la función para buscar el archivo
if findArchive; then
   echo "Leds On, si necesitas apagarlas escribe n y para encenderlas y, y para salir q"
   while [ true ]; do
	read actions
     	if [ "$actions" == "n" ]; then
		echo 0 | sudo tee "$location/brightness"
     	elif [ "$actions" == "y" ]; then
       		echo 255 | sudo tee "$location/brightness"
     	elif [ "$actions" == "q" ]; then
		exit 0
	else
   		echo -e "Comando no reconocido..\n help: n, y, q"
	fi
   done
else
	echo "Leds On, si necesitas apagarlas escribe n y para encenderlas y, y para salir q"
   while [ true ]; do
        read actions
        if [ "$actions" == "n" ]; then
                echo 0 | sudo tee "$location/brightness"
        elif [ "$actions" == "y" ]; then
                echo 255 | sudo tee "$location/brightness"
        elif [ "$actions" == "q" ]; then
                exit 0
        else
                echo -e "Comando no reconocido..\n help: n, y, q"
        fi
   done

   echo "hello"
fi
 	
