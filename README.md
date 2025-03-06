# 🔒 Hardening Script para Linux


## 📌 Descripción  
Este script automatiza el **hardening** de sistemas Linux, reforzando la seguridad a través de configuraciones avanzadas. Aplica políticas de contraseñas, actualizaciones automáticas, restricciones de acceso, configuración de firewall, deshabilitación de servicios inseguros y monitoreo de logs, mejorando la protección del sistema contra amenazas.

## 🚀 Características  
✔️ **Actualización y parcheo del sistema** para reducir vulnerabilidades.  
✔️ **Configuración de políticas de contraseñas seguras** (SHA-512, expiración, complejidad).  
✔️ **Configuración de firewall (UFW/IPTables)** para restringir tráfico no autorizado.  
✔️ **Restricción de acceso SSH** para proteger conexiones remotas.  
✔️ **Deshabilitación de SELinux** y otros servicios inseguros.  
✔️ **Monitoreo y registro de eventos de seguridad**.

## 🛠️ Tecnologías Utilizadas  
- **Bash** 🖥️ (Script principal)  
- **UFW/IPTables** 🔥 (Firewall)  
- **SELinux** 🚨 (Seguridad a nivel de kernel)  
- **Crontab** 🕒 (Automatización de tareas)  
- **ClamAV** 🛡️ (Antivirus para análisis de malware)  

## 🔧 Requisitos Previos  
1️⃣ Tener acceso root o privilegios `sudo`.  
2️⃣ Un sistema basado en **Linux** (Ubuntu, Debian, CentOS, RHEL).  
3️⃣ Conexión a Internet para la instalación de dependencias.  

## ⚡ Instalación  
1. **Clona el repositorio**:  
   ```bash
   git clone https://github.com/FernandoCeGa/Hardening-script.git
   cd Hardening-script
   ```
2. **Otorga permisos de ejecución al script**:  
   ```bash
   chmod +x hardening.sh
   ```
3. **Ejecuta el script con privilegios de administrador**:  
   ```bash
   sudo ./hardening.sh
   ```

## 🎯 Uso  
📌 **Ejemplo de ejecución**:  
```bash
sudo ./hardening.sh
```

📌 **Opciones avanzadas**:  
```bash
sudo ./hardening.sh --log /ruta/personalizada.log  # Guarda logs en una ubicación específica
sudo ./hardening.sh --dry-run  # Modo de prueba sin aplicar cambios
```

## 🤝 Contribuciones  
¡Las contribuciones son bienvenidas! 🚀  

1. **Haz un fork del repositorio** en [GitHub](https://github.com/FernandoCeGa/Hardening-script/fork).  
2. **Crea una nueva rama** para tu funcionalidad:  
   ```bash
   git checkout -b feature/nueva-funcionalidad
   ```
3. **Realiza cambios y haz commit**:  
   ```bash
   git commit -m "Añadir nueva funcionalidad"
   ```
4. **Sube los cambios al repositorio**:  
   ```bash
   git push origin feature/nueva-funcionalidad
   ```
5. **Abre una Pull Request** en [este enlace](https://github.com/FernandoCeGa/Hardening-script/pulls).  

## 📜 Licencia  
Este proyecto está bajo la **Licencia MIT**. Consulta el archivo [LICENSE](LICENSE) para más detalles.  

## 📩 Contacto  
Desarrollado por **Fernando CeGa**.  
✉️ **Correo:** [fcerecedogi@uanl.edu.mx](mailto:fcerecedogi@uanl.edu.mx)  
🔗 **GitHub:** [github.com/FernandoCeGa](https://github.com/FernandoCeGa)  

