#!/bin/bash

caracterAnimation="\ | /"
location=""

# Función para buscar el archivo
findArchive() {
    if find /sys/class/leds/input8::scrolllock -name "input8::scrolllock"; then
	location="/sys/class/leds/input9::scrolllock"
    elif find /sys/class/leds -name "input17::scrolllock"; then
	location="/sys/class/leds/input17::scrolllock"
    elif find /sys/class/leds -name "input19::scrolllock"; then
    	location="/sys/class/leds/input19::scrolllock"
    else
	echo -e  "It was not found on any of the common routes. You must do it manually,\n go to: sys/class/leds and look for a file that contains scrolllock in its name"
    fi
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
    echo "¡Funcionó!"
else
    read routeAuxiliar
fi


