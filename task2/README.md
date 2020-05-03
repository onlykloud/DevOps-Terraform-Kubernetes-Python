# Challenge DevOps Task 2

> ### Pre-requisitos:
Antes de ejecutar el script es necesario contar con los siguientes aplicativos

1. jq (https://stedolan.github.io/jq/)
2. gcloud SDK (https://cloud.google.com/sdk)
3. kubectl (https://kubernetes.io/es/docs/tasks/tools/install-kubectl/)
4. helm (https://helm.sh/docs/intro/install/)
5. python (https://www.python.org/downloads/)
6. docker (https://docs.docker.com/get-docker/)

> ### Herramientas de Desarrollo:
OS: Windows 10 Pro
Bash Tool: Git Bash
Editor: Visual Studio Code

> ### Configuracion de variables de GCP
En el archivo 'main.sh' reemplazar los valores iniciales del service account

1. GCP Project Name - Ejemplo: devops-manuel
GCP_PROJECT="PUT_GCP_PROJECT_HERE"

2. GCP Private Key ID - Ejemplo: 282b19cf817f43240aw984feaca8623aa29af233
GPC_PRIVATE_KEY_ID="PUT_GCP_PRIVATE_KEY_ID_HERE"

3. GCP Private Key - Ejemplo: -----BEGIN PRIVATE KEY-----\-----END PRIVATE KEY-----\n
GPC_PRIVATE_KEY="PUT_PRIVATE_KEY_HERE"

4. GCP Client Email - Ejemplo: gcp-devops@devop-manu.iam.gserviceaccount.com
GPC_CLIENT_MAIL="PUT_GCP_CLIENT_MAIL_HERE"

5. GCP Client ID - Ejemplo: 106512508332840639292
GPC_CLIENT_ID="PUT_GCP_CLIENT_ID_HERE"

6. GCP CLIENT X509 CERT URL - Ejemplo: https://www.googleapis.com/gcp-devops%40devop-manu.iam.gserviceaccount.com
GPC_CLIENT_CERT_URL="PUT_CLIENT_CERT_URL_HERE"

> ### Configuracion de variables de Terraform

1. GCE NAME
GCI_NAME="PUT_GCE_NAME_HERE"
2. GKE NAME
GCI_LOCATION="PUT_LOCATION_HERE"
3. GKE MACHINE TYPE
GKE_MACHINE_TYPE="PUT_MACHINE_TYPE_HERE"

> ### Ejecucion del script

Finalmente ejecutar el comando
# sh ./main.sh

> ### Resultado
