#!/bin/bash
#
# crear_copiar_borrar.sh
# Practica: Crear, copiar, mover y eliminar
# Materia: Sistemas operativos
# Alumno: Crystian Alejandro Romo Ramirez
#
# Descripcion: Automatiza la practica de manejo de archivos y directorios
# en Ubuntu usando los comandos mkdir, cp, rm y ls. El script crea la
# estructura de carpetas, genera un archivo de texto, realiza las copias
# de archivos y de carpetas completas, y finalmente elimina lo indicado.
#
# Uso: ./crear_copiar_borrar.sh
#
# Nota: los nombres de carpeta en Linux distinguen mayusculas de
# minusculas, por lo que aqui se usan siempre en minuscula.

# --- Configuracion inicial -------------------------------------------------

# Carpeta base donde se desarrollara la practica.
base="$HOME/Documentos"

# Rutas de trabajo, definidas una sola vez para no repetirlas mas abajo.
practica1="$base/practica1"
practica2="$base/practica2"

# --- Funciones auxiliares --------------------------------------------------

# Imprime un encabezado que separa cada etapa de la practica,
# para que la salida sea legible y sirva como evidencia.
mostrar_titulo() {
    echo ""
    echo "=============================================="
    echo "  $1"
    echo "=============================================="
}

# --- Verificacion previa ---------------------------------------------------

# Comprobamos que exista la carpeta base antes de trabajar en ella.
if [ ! -d "$base" ]; then
    echo "Error: no se encontro la carpeta $base"
    exit 1
fi

cd "$base" || exit 1

# --- 1. mkdir: crear las carpetas de trabajo -------------------------------

mostrar_titulo "mkdir -> crear practica1 y practica2"

# La opcion -p evita el error si la carpeta ya existe,
# asi el script se puede ejecutar varias veces sin fallar.
mkdir -p "$practica1"
mkdir -p "$practica2"
ls -l "$base"

# --- 2. Crear el archivo Readme.txt ----------------------------------------

mostrar_titulo "Crear Readme.txt dentro de practica1"

# Se escribe el contenido con un here-document en lugar de abrir un
# editor grafico, para que el script no requiera intervencion manual.
cat > "$practica1/Readme.txt" << 'FIN'
Practica de comandos: crear, copiar, mover y eliminar.
Materia: Sistemas operativos.
Este archivo se utiliza para demostrar el comando cp.
FIN

ls -l "$practica1"

# --- 3. cp: copiar un archivo ----------------------------------------------

mostrar_titulo "cp -> copiar Readme.txt de practica1 a practica2"

# La opcion -v (verbose) muestra en pantalla que archivo se copio,
# lo cual sirve como evidencia de la ejecucion.
cp -v "$practica1/Readme.txt" "$practica2/"
ls -l "$practica2"

# --- 4. Crear las carpetas vacia e info ------------------------------------

mostrar_titulo "mkdir -> crear las carpetas vacia e info en practica2"

mkdir -p "$practica2/vacia"
mkdir -p "$practica2/info"

# La carpeta info si lleva contenido; vacia se queda sin archivos.
cat > "$practica2/info/datos.txt" << 'FIN'
Archivo de prueba contenido en la carpeta info.
FIN

ls -l "$practica2"

# --- 5. cp -r: copiar carpetas completas -----------------------------------

mostrar_titulo "cp -r -> copiar las carpetas vacia e info a practica1"

# La opcion -r (recursivo) es obligatoria para copiar directorios,
# ya que cp por si solo unicamente trabaja con archivos.
cp -rv "$practica2/vacia" "$practica1/"
cp -rv "$practica2/info" "$practica1/"
ls -l "$practica1"

# --- 6. rm: eliminar archivo y carpeta -------------------------------------

mostrar_titulo "rm -> eliminar Readme.txt y la carpeta info de practica1"

# rm elimina archivos de forma permanente: no pasan por la papelera.
# Por eso se verifica que el archivo exista antes de intentar borrarlo.
if [ -f "$practica1/Readme.txt" ]; then
    rm -v "$practica1/Readme.txt"
else
    echo "Aviso: Readme.txt no existe en practica1."
fi

# Para borrar una carpeta con contenido se necesita la opcion -r.
if [ -d "$practica1/info" ]; then
    rm -rv "$practica1/info"
else
    echo "Aviso: la carpeta info no existe en practica1."
fi

mostrar_titulo "Estado final de practica1"
ls -la "$practica1"

# --- Fin -------------------------------------------------------------------

echo ""
echo "Practica finalizada correctamente."
exit 0
