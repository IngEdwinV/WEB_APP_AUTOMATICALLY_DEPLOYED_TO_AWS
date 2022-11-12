![Logo](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Logo_de_la_Escuela_Colombiana_de_Ingenier%C3%ADa.svg/2560px-Logo_de_la_Escuela_Colombiana_de_Ingenier%C3%ADa.svg.png)

# WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS
laboratiorio despligue automatico con AWS CLI

A continuación se detalla el proceso de construcción y presentación de evidencias de la automatización con AWS CLI para la creación y despligue de infraestructura

### Creación script .sh 🥸

Cree un archivo .sh el cual tiene como objetivo ejecutar los comandos para la creación de la infraestructura y despligue de instancias EC2 en Amazon AWS, detallo por imagenes los comandos que se utilizaron:

1. Declaración de variables y eliminación de par de llaves y la creación de nuevas

![Script1](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/Script1.png)

2. Creación de la VPC y sub redes con configuración de trafico 

![Script2](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/Script2.png)

3. Se crea grupo de seguridad y su regla de trafico para conexión por SSH

![Script3](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/Script3.png)

4. Se crean las instacias EC2 con su respectiva configuración, validando el estado para su respectiva conexión 

![Script4](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/Script4.png)

5. nos conectamos y realizamos la configuración de la instancia 

![Script5](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/Script5.png)

6. Ejecución del script

![Script6](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/Script6.png)

![Script7](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/Script7.png)

### Evidencias de la creación y despliegue en AWS 👇

A continuación se podran observar las evidencias de la creación en amazon AWS con CLI de la infraestructura

![VPC](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/VPC.png)

![Subredes](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/SubRedes.png)

![TablaRuteo](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/TablaRuteo.png)

![gateway](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/gateway.png)

![EC2](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/EC2.png)

![Reglas](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/Reglas.png)

### Instancias EC2

Estas son las instancias consultadas accediendo por internet

![EC2-1](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/EC2-1.png)

![EC2-2](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/EC2-2.png)

![EC2-3](https://github.com/IngEdwinV/WEB_APP_AUTOMATICALLY_DEPLOYED_TO_AWS/Imagenes/EC2-3.png)



