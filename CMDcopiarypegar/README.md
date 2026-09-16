# Práctica: Crear, copiar, mover y eliminar

## Objetivos

Familiarizarse con el manejo de archivos y directorios en la terminal de Ubuntu, mediante la creación de carpetas, la generación de archivos de texto, la copia de archivos y directorios completos, y la eliminación de los mismos, con el fin de comprender el uso correcto de los comandos `mkdir`, `cp` y `rm` en un flujo de trabajo real.

## Explicación de los comandos

### mkdir — crear carpetas

Crea uno o más directorios nuevos. En esta práctica se utilizó para generar `practica1` y `practica2` dentro de la carpeta Documentos, y posteriormente `vacia` e `info` dentro de `practica2`.

```bash
mkdir practica1
mkdir practica2
```

### Creación de un archivo de texto

Dentro de `practica1` se generó el archivo `Readme.txt` con contenido de prueba, necesario para después demostrar el comando `cp`.

### cp — copiar archivos y carpetas

Copia archivos o directorios de un lugar a otro. Su sintaxis básica es:

```bash
cp [origen] [destino]
```

Se usó primero para copiar un archivo suelto:

```bash
cp ~/Documentos/practica1/Readme.txt ~/Documentos/practica2/
```

Y con la opción `-r` (recursivo) para copiar carpetas completas, ya que `cp` por sí solo no puede copiar directorios:

```bash
cp -r ~/Documentos/practica2/vacia ~/Documentos/practica1
cp -r ~/Documentos/practica2/info ~/Documentos/practica1
```

Otras opciones útiles del comando:

- `cp -v` — modo verbose, muestra en pantalla qué archivo se copió.
- `cp -i` — pregunta antes de sobrescribir un archivo si ya existe uno con el mismo nombre en el destino.

### rm — eliminar archivos y carpetas

Elimina archivos o directorios de forma permanente.

```bash
rm archivo.txt        # elimina un archivo
rm -r carpeta/         # elimina una carpeta y todo su contenido
```

En la práctica se usó para borrar `Readme.txt` y la carpeta `info` dentro de `practica1`, dejando únicamente la carpeta `vacia`.

## Conclusiones técnicas

- `cp` no copia directorios a menos que se use la opción `-r`; intentarlo sin esa bandera produce un error y no copia nada.
- `rm` no envía los archivos a una papelera: la eliminación es inmediata y permanente, por lo que conviene revisar bien la ruta y el nombre antes de ejecutar el comando, especialmente con `rm -r`.
- Linux distingue entre mayúsculas y minúsculas en los nombres de archivos y carpetas (`vacia` y `Vacia` se tratarían como dos carpetas distintas), por lo que hay que mantener consistencia en los nombres usados a lo largo de la práctica.
- Usar `sudo` para crear o editar archivos dentro de la carpeta personal del usuario no es necesario y puede causar problemas de permisos más adelante, ya que el archivo queda como propiedad de root.
- Automatizar estos pasos en un script de Bash permite repetir la práctica de forma consistente y sirve como evidencia clara de que cada comando se ejecuta correctamente.
