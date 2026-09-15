# Comandos Básicos

**Reporte de Práctica — Terminal de Linux (Ubuntu)**

Miguel Ángel Barrón Hernández · 8 de septiembre de 2026

---

Esta práctica tiene como objetivo familiarizarse con los comandos básicos de navegación y listado de archivos en la terminal de Linux (Ubuntu). A continuación se documentan las pruebas realizadas, junto con las capturas de pantalla correspondientes y la explicación de cada comando utilizado.

## 1. Listado de archivos: `ls`, `ls -l` y `ls -la`

Se inició la práctica utilizando el comando `ls` para mostrar el contenido de la carpeta personal (home). Después se utilizó `ls -l` para obtener un listado detallado con permisos, dueño, grupo, tamaño y fecha de modificación de cada carpeta. Finalmente, con `ls -la` se incluyeron también los archivos y carpetas ocultos, es decir, aquellos cuyo nombre comienza con un punto (como `.bashrc`, `.profile` o `.ssh`).

![Salida de los comandos ls, ls -l y ls -la](CMDbasica1.png)

*Figura 1. Salida de los comandos `ls`, `ls -l` y `ls -la` en la terminal.*

**Observaciones**

- La carpeta personal contiene los directorios estándar: Descargas, Documentos, Escritorio, Imágenes, Música, Plantillas, Público y Videos.
- Con `ls -l` se puede identificar que todas las carpetas pertenecen al usuario `ubucrys` y comparten permisos `drwxr-xr-x`.
- Con `ls -la` aparecen además archivos de configuración ocultos como `.bash_history`, `.bashrc`, `.profile`, `.cache`, `.config`, `.local` y `.ssh`, así como las entradas especiales `.` y `..` que representan el directorio actual y el directorio padre.

## 2. Navegación entre carpetas: `cd`

Posteriormente se practicó la navegación entre directorios utilizando el comando `cd`. Primero se ingresó a la carpeta Descargas con `cd Descargas`, después se regresó al directorio anterior con `cd ..` y, finalmente, se usó `cd ~` para volver directamente a la carpeta personal (home) desde cualquier ubicación.

![Secuencia de navegación con cd](CMDbasica2.png)

*Figura 2. Secuencia de navegación con `cd Descargas`, `cd ..` y `cd ~`.*

**Observaciones**

- El indicador de la terminal (prompt) cambia para mostrar la carpeta actual, por ejemplo `~/Descargas`.
- `cd ..` sube un nivel en la jerarquía de directorios, regresando de Descargas al home (`~`).
- `cd ~` (o simplemente `cd` sin argumentos) regresa siempre a la carpeta personal del usuario, sin importar en qué carpeta se encuentre.

## 3. Tamaños legibles: `ls -lh`

Por último, se ejecutó el comando `ls -lh`, el cual muestra el mismo listado detallado que `ls -l`, pero presenta los tamaños de archivo en un formato legible para humanos, usando unidades como K (kilobytes), M (megabytes) o G (gigabytes) en lugar de mostrar el tamaño en bytes.

![Salida del comando ls -lh](CMDbasica3.png)

*Figura 3. Salida del comando `ls -lh` con tamaños en formato legible (4.0K).*

**Observaciones**

- Todas las carpetas del home ocupan 4.0K, ya que un directorio solo almacena las referencias a sus archivos internos, no su contenido.
- La carpeta `snap`, al contener más subcarpetas, aparece con un tamaño total (8.0K) mayor al resto.

## 4. Resumen de comandos

| Comando | Descripción |
|---|---|
| `ls` | Lista el contenido de la carpeta actual. |
| `ls -l` | Lista en formato largo (permisos, dueño, tamaño, fecha). |
| `ls -la` | Incluye archivos ocultos (los que empiezan con punto). |
| `ls -lh` | Muestra los tamaños en formato legible (K, M, G). |
| `cd carpeta` | Entra a una carpeta. |
| `cd ..` | Sube un nivel. |
| `cd ~` / `cd` | Regresa a la carpeta personal (home). |

## 5. Conclusión

Esta práctica permitió comprender el uso de los comandos fundamentales para explorar el sistema de archivos desde la terminal de Linux: `ls`, en sus distintas variantes, para listar contenido, y `cd` para desplazarse entre directorios. El dominio de estos comandos es la base para cualquier tarea posterior de administración de archivos y del sistema operativo desde la línea de comandos.
