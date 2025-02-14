#!/bin/bash

caracterAnimation="\ | /"
location=""

findArchive() {
    # Iterar desde input4 hasta input40
    for i in {4..40}; do
        if [ -e "/sys/class/leds/input${i}::scrolllock" ]; then
            location="/sys/class/leds/input${i}::scrolllock"
            break
        fi
    done

    if [ -z "$location" ]; then
        echo "It was not found on any of the common routes. You must do it manually,"
        echo "go to: /sys/class/leds and look for a file that contains 'scrolllock'."
        echo "Escribe la ruta: "
        read auxiliarRoute
        location="$auxiliarRoute"  # Asignar la ruta manual a 'location'
    fi

    if [ -z "$location" ]; then
        echo "No se especificó una ruta válida. Abortando."
        return 1
    fi

    echo "Archivo encontrado en: $location"
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
    echo "Leds On, si necesitas apagarlas escribe 'n', para encenderlas 'y', y para salir 'q'"
    while true; do
        read actions
        case "$actions" in
            n) echo 0 | sudo tee "$location/brightness" ;;
            y) echo 255 | sudo tee "$location/brightness" ;;
            q) exit 0 ;;
            *) echo -e "Comando no reconocido..\n help: n, y, q" ;;
        esac
    done
else
    echo "No se pudo encontrar la ruta del archivo. Abortando."
    exit 1
fi
