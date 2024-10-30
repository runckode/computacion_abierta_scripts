# Script de Respaldo y Restauración en Unix/Linux

Este repositorio contiene un script de Bash para realizar respaldos automáticos de archivos en un sistema Unix/Linux. El script crea un respaldo comprimido, verifica el espacio en disco, maneja permisos y registra las operaciones en un archivo de log.

---

## Instrucciones

### 1. Configuración y Ejecución del Script

1. **Crear el script `backup.sh`**
   - Crea el archivo `backup.sh` en el directorio `~/scripts`.
   - Asegúrate de que el contenido del script esté guardado en `~/scripts/backup.sh`.

2. **Hacer el script ejecutable**
   - Ejecuta el siguiente comando para que el script sea ejecutable:
     ```bash
     chmod +x ~/scripts/backup.sh
     ```

3. **Ejecutar el script manualmente**
   - Ejecuta el script con el siguiente comando:
     ```bash
     ~/scripts/backup.sh
     ```

### 2. Automatización con `cron`

1. **Editar el archivo de `crontab`**
   - Abre el archivo de configuración de cron con:
     ```bash
     crontab -e
     ```

2. **Agregar el cronjob**
   - Para ejecutar el respaldo automáticamente cada domingo a las 2:00 AM, agrega esta línea:
     ```bash
     0 2 * * 0 ~/scripts/backup.sh
     ```

### 3. Restauración del Respaldo

1. **Restaurar un respaldo específico**
   - Usa el siguiente comando para restaurar un respaldo específico:
     ```bash
     tar -xzf ~/scripts/backups/backup_YYYY-MM-DD.tar.gz -C ~/data
     ```
   - Reemplaza `YYYY-MM-DD` con la fecha del respaldo que deseas restaurar.

### 4. Verificación del Log

1. **Revisar el archivo de log**
   - Usa este comando para verificar el log de los respaldos:
     ```bash
     cat ~/scripts/registro_respaldo.log
     ```

---

## Checklist de Funcionalidades

- [x] Respaldo automático y manual
- [x] Registro de eventos en archivo de log
- [x] Restauración de respaldos por fecha específica
- [x] Automatización semanal con `cron`