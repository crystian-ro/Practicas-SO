# Compartir archivos entre Ubuntu y Ubuntu (Samba)

**Estudiante:** [Tu nombre]
**Materia / Docente:** [Materia] / [Docente]
**Fecha de la práctica:** 11 de noviembre

## 1. Objetivos

**General:** compartir una carpeta entre dos equipos con Ubuntu dentro de la misma red local, usando el protocolo SMB (Samba).

**Específicos:**
- Verificar la conectividad entre los dos equipos con `ping`.
- Compartir una carpeta (`IsrAMBA`) desde un equipo servidor.
- Acceder a la carpeta compartida desde el equipo cliente con el explorador de archivos.
- Documentar la práctica con evidencias de terminal y de interfaz gráfica.

## 2. Escenario

| Rol | Usuario / equipo | Dirección IP | Qué hace |
|---|---|---|---|
| Servidor | `ubucrys@ublpc` | 192.168.1.2 | Comparte la carpeta `IsrAMBA` |
| Cliente | `israel@israel-BOM-WXX9` | 192.168.1.7 | Accede a la carpeta compartida |

Ambos equipos usan Ubuntu y están en la red 192.168.1.0/24.

## 3. Jerarquía del repositorio

```
.
├── README.md
├── Codigo/        # Archivos de configuración y scripts de ejemplo
│   ├── smb.conf.ejemplo
│   ├── configurar_servidor.sh
│   └── conectar_cliente.sh
├── Terminal/      # Evidencias de comandos (ping)
│   ├── ping_servidor_a_cliente.png
│   ├── ping_cliente_a_servidor.png
│   └── ping_cliente_a_servidor_detalle.png
└── Reporte/       # Evidencias de la interfaz gráfica
    ├── 01_cliente_ve_comparticiones_del_servidor.png
    ├── 02_servidor_carpeta_IsrAMBA_compartida.png
    ├── 03_servidor_contenido_de_IsrAMBA.png
    └── 04_cliente_accede_a_isramba_en_192.168.1.2.png
```

## 4. Procedimiento y explicación de comandos

### 4.1 En el servidor (192.168.1.2)

| Paso | Comando | Explicación |
|---|---|---|
| 1 | `sudo apt update && sudo apt install -y samba` | Actualiza la lista de paquetes e instala Samba, que implementa SMB en Linux. |
| 2 | `mkdir -p ~/Escritorio/IsrAMBA` | Crea la carpeta que se va a compartir. |
| 3 | `sudo nano /etc/samba/smb.conf` | Se agrega al final el bloque `[isramba]` (ver `Codigo/smb.conf.ejemplo`) con la ruta, el permiso de escritura y el usuario válido. |
| 4 | `sudo smbpasswd -a ubucrys` | Crea la contraseña SMB del usuario, distinta de la del inicio de sesión. |
| 5 | `sudo systemctl restart smbd` | Reinicia el servicio para aplicar la configuración. |
| 6 | `sudo ufw allow samba` | Permite el tráfico de Samba si el firewall está activo. |
| 7 | `ip -4 addr` | Muestra la IP del servidor (192.168.1.2). |

También se puede compartir desde la interfaz gráfica: clic derecho sobre la carpeta → *Propiedades* → *Compartir en red local*. En la captura del servidor, la carpeta `IsrAMBA` muestra el ícono de carpeta compartida.

### 4.2 En el cliente (192.168.1.7)

| Paso | Comando | Explicación |
|---|---|---|
| 1 | `ping -c 4 192.168.1.2` | Envía 4 paquetes ICMP al servidor para comprobar que hay conexión. |
| 2 | `sudo apt install -y smbclient cifs-utils` | Instala las herramientas cliente de SMB (opcional si se usa solo el explorador). |
| 3 | `smbclient -L //192.168.1.2 -U ubucrys` | Lista los recursos compartidos del servidor. |
| 4 | Explorador de archivos → *Otras ubicaciones* → `smb://192.168.1.2` | Abre las comparticiones del servidor de forma gráfica. |
| 5 | `sudo mount -t cifs //192.168.1.2/isramba /mnt/isramba -o username=ubucrys` | Alternativa por terminal: monta la carpeta compartida en `/mnt/isramba`. |

> Los scripts de `Codigo/` reúnen estos pasos como ejemplo.

## 5. Evidencias

### 5.1 Conectividad (Terminal)

**Cliente → servidor** (`ping -c 4 192.168.1.2`): 4 paquetes enviados, 4 recibidos, 0 % de pérdida, tiempo promedio de 0.847 ms.



**Servidor → cliente** (`ping -c 4 192.168.1.7`): 4 paquetes enviados, 4 recibidos, 0 % de pérdida, tiempo promedio de 0.842 ms.



### 5.2 Carpeta compartida (Reporte)

**El cliente ve las comparticiones del servidor.** En "Comparticiones Windows en 192.168.1.2" aparecen `IsrAMBA` y `print$`.


**El servidor tiene la carpeta `IsrAMBA` en el Escritorio**, marcada como compartida.



**Contenido de `IsrAMBA` en el servidor:** contiene la subcarpeta `1`.



**Contenido visto desde el cliente** en `isramba en 192.168.1.2`: aparece la misma subcarpeta `1`, con fecha de modificación "Ayer, 9:09", igual que en el servidor.



## 6. Resultados

| Prueba | Resultado |
|---|---|
| Conectividad cliente → servidor | Correcta (0 % de pérdida) |
| Conectividad servidor → cliente | Correcta (0 % de pérdida) |
| Carpeta `IsrAMBA` visible desde el cliente | Sí |
| Contenido del servidor visible desde el cliente | Sí (carpeta `1`) |

## 7. Conclusiones técnicas

- La comunicación entre los dos equipos es estable: ambos `ping` tuvieron 0 % de pérdida y latencias menores a 1.1 ms, lo normal en una red local cableada o Wi-Fi cercana.
- Comprobar la conectividad con `ping` antes de compartir descarta fallas de red y permite centrar el diagnóstico en Samba si algo falla.
- Samba permite que Ubuntu comparta carpetas con el protocolo SMB, que también entienden Windows y otros sistemas. Por eso el explorador del cliente muestra el apartado "Comparticiones Windows".
- El recurso `print$` aparece de forma predeterminada en Samba (controladores de impresión) y no forma parte de la práctica.
- El nombre del recurso (`isramba`) puede ser distinto del nombre de la carpeta local (`IsrAMBA`), porque lo define el bloque de `smb.conf` o el nombre elegido al compartir.
- Compartir una carpeta exige varios elementos a la vez: servicio activo, usuario SMB con contraseña, permisos del sistema de archivos y firewall abierto. Si falta uno, el cliente no puede acceder.
- Mejoras posibles: restringir el acceso con `valid users`, usar permisos de solo lectura donde no se necesite escribir y limitar el acceso a la red local.

## 8. Referencias

- Documentación de Ubuntu: *Install and Configure Samba*, https://ubuntu.com/server/docs/samba-introduction
- Proyecto Samba: https://www.samba.org
