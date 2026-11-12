# Compartir archivos entre Ubuntu y Windows (Samba)

**Estudiante:** [Tu nombre]
**Materia / Docente:** [Materia] / [Docente]
**Fecha de la práctica:** [Fecha]

## 1. Objetivos

**General:** compartir una carpeta desde un equipo Ubuntu (servidor) hacia un equipo Windows (cliente) dentro de la misma red local, usando el protocolo SMB con Samba.

**Específicos:**
- Verificar la conectividad entre ambos equipos con `ping`.
- Compartir una carpeta de Ubuntu con Samba.
- Acceder a la carpeta desde Windows con el Explorador de archivos y con la terminal (`net use`).
- Documentar la práctica con evidencias y explicar las diferencias entre ambos sistemas.

## 2. Escenario

| Rol | Sistema | Usuario / equipo | Dirección IP |
|---|---|---|---|
| Servidor | Ubuntu (Samba) | [usuario@equipo] | [IP de Ubuntu, ej. 192.168.1.2] |
| Cliente | Windows | [usuario / equipo] | [IP de Windows, ej. 192.168.1.7] |

## 3. Jerarquía del repositorio

```
.
├── README.md
├── Codigo/        # Scripts Bash y comandos de la práctica
│   ├── smb.conf.ejemplo
│   ├── configurar_servidor.sh      (Ubuntu)
│   ├── probar_conectividad.sh      (Ubuntu)
│   └── comandos_windows.txt        (CMD / PowerShell)
├── Terminal/      # Capturas de comandos (ping, net use, smbd activo)
└── Reporte/       # Capturas gráficas y el PDF del reporte
```

## 4. Procedimiento y explicación de comandos

### 4.1 En el servidor Ubuntu

| Paso | Comando | Explicación |
|---|---|---|
| 1 | `sudo apt update && sudo apt install -y samba` | Instala Samba, que implementa SMB en Linux. |
| 2 | `mkdir -p ~/Escritorio/CompartidaWin` | Crea la carpeta que se va a compartir. |
| 3 | `sudo nano /etc/samba/smb.conf` | Se agrega el bloque `[compartida]` (ver `Codigo/smb.conf.ejemplo`). |
| 4 | `testparm` | Valida la sintaxis de la configuración. |
| 5 | `sudo smbpasswd -a ubucrys` | Crea la contraseña SMB del usuario, distinta de la del inicio de sesión. |
| 6 | `sudo systemctl restart smbd` | Reinicia el servicio para aplicar los cambios. |
| 7 | `sudo ufw allow samba` | Abre el firewall para Samba si está activo. |
| 8 | `ip -4 addr` | Muestra la IP del servidor. |

El script `Codigo/configurar_servidor.sh` automatiza estos pasos.

### 4.2 En el cliente Windows

| Paso | Comando | Explicación |
|---|---|---|
| 1 | `ping -n 4 <IP_Ubuntu>` | Comprueba la conectividad (en Windows `-n` indica la cantidad de paquetes). |
| 2 | `Test-NetConnection -ComputerName <IP_Ubuntu> -Port 445` | Verifica que el puerto SMB del servidor responde. |
| 3 | `net view \\<IP_Ubuntu>` | Lista los recursos compartidos. |
| 4 | `net use Z: \\<IP_Ubuntu>\compartida /user:ubucrys` | Conecta la carpeta como la unidad Z:. |
| 5 | `dir Z:\` | Muestra el contenido de la carpeta compartida. |
| 6 | `net use Z: /delete` | Desconecta la unidad. |

Forma gráfica: Explorador de archivos → barra de direcciones → `\\<IP_Ubuntu>\compartida`.

## 5. Evidencias

> Completa esta sección con tus capturas, guardándolas en `Terminal/` y `Reporte/`.

| Evidencia | Carpeta | Archivo sugerido |
|---|---|---|
| `ping` de Windows a Ubuntu | Terminal | `ping_windows_a_ubuntu.png` |
| `ping` de Ubuntu a Windows | Terminal | `ping_ubuntu_a_windows.png` |
| Servicio `smbd` activo en Ubuntu | Terminal | `smbd_activo.png` |
| `net use` y `dir Z:\` en Windows | Terminal | `net_use_windows.png` |
| Carpeta compartida en Ubuntu | Reporte | `ubuntu_carpeta_compartida.png` |
| Explorador de Windows con la carpeta | Reporte | `windows_explorador.png` |

Para insertarlas: `![Descripción](Terminal/ping_windows_a_ubuntu.png)`

## 6. Resultados

| Prueba | Resultado |
|---|---|
| Ping Windows a Ubuntu | [completar] |
| Ping Ubuntu a Windows | [completar] |
| Carpeta visible desde Windows | [completar] |
| Crear un archivo desde Windows y verlo en Ubuntu | [completar] |

## 7. Conclusiones técnicas

- Samba permite que Ubuntu comparta carpetas con Windows porque ambos hablan SMB; el sistema operativo del servidor es transparente para el cliente.
- La contraseña SMB es independiente de la cuenta de Linux y debe crearse con `smbpasswd`.
- El `ping` puede fallar hacia Windows aunque SMB funcione, porque el firewall de Windows suele bloquear las solicitudes de eco entrantes. Por eso conviene probar también el puerto 445.
- Además de la configuración de Samba, intervienen los permisos del sistema de archivos de Ubuntu y el firewall de ambos equipos.
- [Agrega aquí una conclusión basada en lo que observaste en tu práctica.]

## 8. Referencias

- Documentación de Ubuntu: *Install and Configure Samba*, https://ubuntu.com/server/docs/samba-introduction
- Proyecto Samba: https://www.samba.org
- Microsoft Learn: *net use* y *Test-NetConnection*.
