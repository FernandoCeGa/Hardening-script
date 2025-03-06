#!/bin/bash

# Crear archivo de registro de seguridad
sudo touch /var/log/security.log

# Definir el archivo de registro
log_file="/var/log/security.log"

# Agregar fecha y hora a las entradas del registro
timestamp() {
  date +"%Y-%m-%d %T"
}

# Función para escribir en el archivo de registro
write_log() {
  echo "$(timestamp) $1" >> "$log_file"
}

# Registro de la actividad del script
write_log "Iniciando secuencia de comandos"


# Actualizar el sistema operativo
write_log "Actualizando el sistema operativo ..."
sudo yum update >> /var/log/security.log
sudo yum upgrade -y >> /var/log/security.log
write_log "La actualizacion a finalizado."

# Políticas de cuenta de usuario
write_log "Configurando contraseñas"
write_log "Contraseña con valides de 3 meses"
sudo sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS 90/' /etc/login.defs
write_log "Actualizando el algoritmo hash de contraseña a SHA-512 y Hacer cumplir contraseñas seguras (8 caracteres al menos)"
sudo sed -i 's/^password.*pam_unix.so.*/password    pam_unix.so sha512 minlen=8/' /etc/pam.d/common-password
write_log "Configurando de contraseñas finalizada"


# Hacer cumplir las políticas de contraseñas seguras y de nuevo juicio con PAM
write_log "Haciendo cumplir las políticas de contraseñas seguras y de nuevo juicio con PAM ..."
sudo sed -i 's/password    requisite     pam_cracklib.so try_first_pass retry=3 type=/password    requisite     pam_pwquality.so try_first_pass retry=3 type=/' /etc/pam.d/system-auth >> /var/log/security.log
sudo sed -i 's/password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok/password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=1/' /etc/pam.d/system-auth >> /var/log/security.log

# Configurar sudoers
write_log "$(whoami) ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers >> /var/log/security.log

# Configurar banner de inicio de sesión
write_log "Creando banner"
echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # #" >> /etc/motd 
echo "#       Esto pertenece a <1937852>                      #" >> /etc/motd
echo "#       Todas las actividades estan siendo              #" >> /etc/motd
echo "#       monitoreadas por <Fernando> y los               #" >> /etc/motd
echo "#       cambios no autorizados seran procesados.        #" >> /etc/motd
echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # #" >> /etc/motd
write_log "Banner Creado"


# Configurar permisos y propiedad de archivos predeterminados
umask 007 >> /var/log/security.log
write_log "umask 007" >> ~/.bashrc >> /var/log/security.log

# Archivos creados por el usuario definido tendrán permisos predeterminados 700, mientras que los archivos creados por otros tendrán permisos 755.
write_log "if [ \"\$(id -u)\" -eq "$(id -u Fernando)" ]; then" >> ~/.bashrc >> /var/log/security.log
write_log "    umask 007" >> ~/.bashrc >> /var/log/security.log
write_log "else" >> ~/.bashrc >> /var/log/security.log
write_log "    umask 022" >> ~/.bashrc >> /var/log/security.log
write_log "fi" >> ~/.bashrc >> /var/log/security.log

# Configuración del cortafuegos
write_log "Configurando el cortafuegos..."
ufw default deny incoming >> /var/log/security.log
ufw default allow outgoing >> /var/log/security.log
ufw enable >> /var/log/security.log
write_log "Configurando el cortafuegos finalizada"

# Configuración de SELinux
write_log "Deshabilitar SELinux"
sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config >> /var/log/security.log
setenforce 0 >> /var/log/security.log

# Instalación del antivirus
write_log "Instalando antivirus"
echo Instalar ClamAV >> /var/log/security.log
yum install clamav clamd -y >> /var/log/security.log
write_log "Instalacion del antivirus finalizada"


# Configuración de SSH
write_log "Configurando SSH..."
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config >> /var/log/security.log
sed -i 's/#StrictModes yes/StrictModes yes/g' /etc/ssh/sshd_config >> /var/log/security.log
sed -i 's/#LogLevel INFO/LogLevel INFO/g' /etc/ssh/sshd_config >> /var/log/security.log
service ssh restart >> /var/log/security.log
write_log "Configuración de SSH completa."

# Configuración de la seguridad del núcleo
write_log "Configurando la seguridad del núcleo..."
echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf >> /var/log/security.log
echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf >> /var/log/security.log
echo "net.ipv4.icmp_echo_ignore_all = 1" >> /etc/sysctl.conf >> /var/log/security.log
sysctl -p >> /var/log/security.log
write_log "Configuración de la seguridad del núcleo completa."

# Configuración de los mensajes del sistema
write_log "Configurando los mensajes del sistema..."
logrotate -f /etc/logrotate.d/rsyslog >> /var/log/security.log
tar -czf /var/log/syslog-$(date +%Y%m%d).tar.gz /var/log/syslog* >> /var/log/security.log
write_log "Configuración de los mensajes del sistema completa."
write_log "Todas las tareas de seguridad se han completado."
