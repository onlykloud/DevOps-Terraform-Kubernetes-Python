# Challenge DevOps

> ### Pre-requisitos:

> #### Cuenta  GCP (Google Cloud Platform) - Utilizar cuenta free o crear una para evitar cobros a tu persona.
> #### Crear un Service Account y bajar las credenciales en formato json.


## TASK 1: 

Crear un script bash o makefile, que acepte parámetros (CREATE, DESTROY y OUTPUT) con los siguientes pasos:

Exportar las variables necesarias para crear recursos en GCP (utilizar las credenciales previamente descargadas). 

Utilizar terraform o pulumi para crear un Cluster de Kubernetes de un solo nodo (GKE).

Instalar ingress controller en el Cluster de k8s.

Crear una imagen docker para desplegar una aplicación tipo RESTFUL API, basada en python que responda a siguientes dos recursos:

/greetings: message —> “Hello World from $HOSTNAME”.

/square: message —>  number: X, square: Y, donde Y es el cuadrado de X. Se espera un response con el cuadrado.

Subir la imagen el registry propio del proyecto gcp ej: gcr.io/$MYPROJECT/mypythonapp.

Desplegar la imagen con los objetos mínimos necesarios (no utilizar pods ni replicasets directamente).

El servicio debe poder ser consumido públicamente.

> #### NOTA: variabilizar todos los campos que lo ameritan, por ejemplo el PROJECT, para que el script pueda ser ejecutado por otra persona con otra cuenta GCP.

  

## TASK 2:

Crear un script bash o makefile, con los siguientes pasos:

Exportar las variables necesarias para crear recursos en GCP (utilizar las credenciales previamente descargadas).

Utilizar terraform o pulumi para crear un Cluster de Kubernetes de un solo nodo (GKE).

Crear una VM basada en Centos

Instalar Jenkins en la VM (Puede ser Instalado con Docker o como Servicio, pero es importante que la instalación se realice a través de un playbook de ansible)

Instalar plugins estándar de pipeline,

Crear un sharedlib que pueda compilar maven.

Crear un Job que haga uso del sharedlib para compilar exitosamente un proyecto java simple tipo “Hello World”

El repositorio para la aplicación de Java debe ser publico.

> #### Nota: Todo debe realizarse de manera automática y que sea idempotente, para que cualquier persona pueda alcanzar el mismo resultado con sus propia cuenta, project y credenciales. En el uso de ansible se penalizara para la evaluación la no utilización de los módulos especializados y por su sustitución de modelos genéricos como shell y command.