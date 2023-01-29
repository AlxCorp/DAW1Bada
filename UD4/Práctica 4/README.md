## Práctica 4.4: deployment of an architecture EFS-EC2-MultiAZ in the CLoud (AWS)
### Alejandro Priego Izquierdo

El objetivo principal de esta práctica será montar TRES servidores web con el mismo contenido (una web de películas). Este contenido debe estar alojado en un servicio AWS EFS y sincronizado en todos los servidores mediante el protocolo NFS.  
Como segundo objetivo, debemos montar un Balanceador de Carga que reparta dicha carga entre los tres servidores.  


1. En primer lugar, crearemos tres grupos de seguridad.  
   - WEB (Puerto 80 desde IP del Balanceador, 22 desde Todas)  
   - FS (Puerto 2049 desde IP de Servidores WEBs, 22 desde Todas)  
   - Load Balancer (Puerto 80 y puerto 22 desde Todas)  

2. Crearemos los 3 servidores WEB, en el servicio AWS EC2:
   - Ubuntu 22.04  
   - t2.micro  
   - Par claves para entrar por SSH
   - VPCs Distintas para mayor estabilidad ante fallos.
   - Grupo de Seguridad WEB
   - Detalles Avanzados > Datos de Usuario  

            #!/bin/bash
            apt update
            apt install apache2 -y
            systemctl reboot

3. También dejaremos creada la máquina para el Balanceador de Carga:
   - Ubuntu 22.04  
   - t2.micro  
   - Par claves para entrar por SSH
   - Grupo de Seguridad Load Balancer
   - Asignamos IP Elástica

4. Creamos el Sistema de Archivos EFS:
   - En nuestro caso (fs-0d34b43366b3004d2)
   - Guardamos el Nombre de DNS (fs-0d34b43366b3004d2.efs.us-east-1.amazonaws.com)
   - Configuramos Grupos de Seguridad para las diferentes zonas
     - Red > Administrar > Grupos de Seguridad > Cambiamos "Default" por "FS"
  
5. 

