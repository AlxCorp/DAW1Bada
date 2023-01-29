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
            apt install nfs-utils
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
  
5. Entramos en cada uno de los nodos del cluster mediante SSH:
   - Creamos una nuevar carpeta  

         mkdir /var/www/html/nfs-mount

   - Sincronizamos el contenido del contenedor NFS con esta carpeta

         sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0d34b43366b3004d2.efs.us-east-1.amazonaws.com:/ /var/www/html/nfs-mount

   - Esto debemos realizarlo cada vez que reiniciemos el servidor
   - Modificamos el archivo /etc/apache2/sites-enabled/000-default.conf
     - Cambiamos el Document Root, agregando el directorio /nfs-mount al final de la línea  
  
  
6. Entramos al Balanceador:
   - Instalamos los siguientes plugins de apache  
  
         sudo a2enmod proxy proxy_http proxy_balancer lbmethod_bytraffic

   - Modificamos el fichero /etc/apache2/sites-enabled/000-default.conf con la siguiente configuración

         <VirtualHost *:80>
				# The ServerName directive sets the request scheme, hostname and port that
				# the server uses to identify itself. This is used when creating
				# redirection URLs. In the context of virtual hosts, the ServerName
				# specifies what hostname must appear in the request's Host: header to
				# match this virtual host. For the default virtual host (this file) this
				# value is not decisive as it is used as a last resort host regardless.
				# However, you must set it for any further virtual host explicitly.
				#ServerName www.example.com

				ServerAdmin webmaster@localhost
				DocumentRoot /var/www/html


				ProxyRequests Off
				ProxyPreserveHost On

				<Location /balancer-manager>
						SetHandler balancer-manager
				</Location>

				ProxyPass /balancer-manager !

				<Proxy balancer://mycluster>
						BalancerMember http://172.31.5.121:80
						BalancerMember http://172.31.1.136:80
						BalancerMember http://172.31.7.231:80

						ProxySet lbmethod=byrequests
				</Proxy>

				ProxyPass / balancer://mycluster/
				ProxyPassReverse / balancer://mycluster/

				# Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
				# error, crit, alert, emerg.
				# It is also possible to configure the loglevel for particular
				# modules, e.g.
				#LogLevel info ssl:warn

				ErrorLog ${APACHE_LOG_DIR}/error.log
				CustomLog ${APACHE_LOG_DIR}/access.log combined

				# For most configuration files from conf-available/, which are
				# enabled or disabled at a global level, it is possible to
				# include a line for only one particular virtual host. For example the
				# following line enables the CGI configuration for this host only
				# after it has been globally disabled with "a2disconf".
				#Include conf-available/serve-cgi-bin.conf
		   </VirtualHost>

   - Reiniciamos Apache

         sudo systemctl restart apache2
