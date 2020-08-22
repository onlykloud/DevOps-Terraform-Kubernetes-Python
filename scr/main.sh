
gpcVariableDefinition () {
    echo "
    #############################################################
    ## [1]. DEFINICION DE VARIABLES DEL SERVICE ACCOUNT DE GCP ##
    #############################################################
    "

    ## GCP Project Name - Ejemplo: devops-manuel
    GCP_PROJECT="PUT_GCP_PROJECT_HERE"
    ## GCP Private Key ID - Ejemplo: 282b19cf817f43240aw984feaca8623aa29af233
    GPC_PRIVATE_KEY_ID="PUT_GCP_PRIVATE_KEY_ID_HERE"
    ## GCP Private Key - Ejemplo: -----BEGIN PRIVATE KEY-----\-----END PRIVATE KEY-----\n
    GPC_PRIVATE_KEY="PUT_PRIVATE_KEY_HERE"
    ## GCP Client Email - Ejemplo: gcp-devops@devop-manu.iam.gserviceaccount.com
    GPC_CLIENT_MAIL="PUT_GCP_CLIENT_MAIL_HERE"
    ## GCP Client ID - Ejemplo: 106512508332840639292
    GPC_CLIENT_ID="PUT_GCP_CLIENT_ID_HERE"
    ## GCP CLIENT X509 CERT URL - Ejemplo: https://www.googleapis.com/robot/v1/metadata/x509/gcp-devops%40devop-manu.iam.gserviceaccount.com
    GPC_CLIENT_CERT_URL="PUT_CLIENT_CERT_URL_HERE"
}

terraformVariableDefinition () {
    echo "
    #################################################
    ## [1.1]. DEFINICION DE VARIABLES DE TERRAFORM ##
    #################################################
    "

    ## GPC LOCATION
    GPC_LOCATION="PUT_GKE_LOCATION_HERE"
    ## GKE NAME
    GKE_NAME="PUT_GKE_NAME_HERE"
    ## GKE NODE POOL NAME
    GKE_NODE_POOL="PUT_GKE_NODEPOOL_NAME_HERE"
    ## GKE MACHINE TYPE
    GKE_MACHINE_TYPE="PUT_GKE_MACHINE_TYPE_HERE"

}

replaceGpcVariables () {
    echo "
    ###############################################################
    ## [2]. REEMPLAZAR VARIABLES EN json DE CONFIGURACION DE GCP ##
    ###############################################################
    "

    jq -n '{ "type": "service_account", "project_id": $gcp_project, 
                                        "private_key_id": $gcp_private_key_id, 
                                        "private_key": $gcp_private_key, 
                                        "client_email": $gcp_client_mail, 
                                        "client_id": $gcp_client_id,
                                        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
                                        "token_uri": "https://oauth2.googleapis.com/token",
                                        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
                                        "client_x509_cert_url": $gcp_gpc_client_cert_url  } ' \
        --arg gcp_project $GCP_PROJECT  \
        --arg gcp_private_key_id $GPC_PRIVATE_KEY_ID  \
        --arg gcp_private_key "$GPC_PRIVATE_KEY"  \
        --arg gcp_client_mail $GPC_CLIENT_MAIL  \
        --arg gcp_client_id $GPC_CLIENT_ID  \
        --arg gcp_gpc_client_cert_url $GPC_CLIENT_CERT_URL \
        > terraform/account.json

    sed -i 's+\\n+n+g' terraform/account.json
}

terraformInstallationByOs () {
    echo "
    ############################################
    ## [3]. INSTALACION DE TERRAFORM SEGUN OS ##
    ############################################
    "

    ## Identificar el OS
    case "$OSTYPE" in   solaris*) OS_TYPE=solaris;;   darwin*)  OS_TYPE=darwin;;    linux*)   OS_TYPE=linux;;   bsd*)     OS_TYPE=freebsd;;   msys*)    OS_TYPE=windows;;   *)        OS_TYPE=unknown;; esac

    ## Identificar la ultima versión de Terraform
    VERSION=($(curl -s https://api.github.com/repos/hashicorp/terraform/releases 2> /dev/null | awk '/tag_name/ {print $2}' | cut -d '"' -f 2 | cut -d 'v' -f 2))

    ## Identificar la Arquitectura del Procesador
    MACHINE_TYPE=($(uname -m))

    if [ ${MACHINE_TYPE} == 'x86_64' ]; then
    PROC=amd64
    else
    PROC=386
    fi

    ## Generar la URL de Descarga
    FILENAME="terraform_${VERSION}_${OS_TYPE}_${PROC}.zip"
    LINK="https://releases.hashicorp.com/terraform/${VERSION}/${FILENAME}"

    ## Descargar el instalador segun el OS
    curl -o "$FILENAME" "$LINK"

    ## Extraer el archivo zip
    unzip -qq "$FILENAME" || exit 1

    ## Mover el instalador a la carpeta del proyecto de terraform
    mv terraform.exe "terraform"

    ## Eliminar el archivo ZIP
    rm -rf "$FILENAME"

}

replaceTerraformVariables () {
    echo "
    ###################################################
    ## [4]. REEMPLAZAR VARIABLES EN terraform.tfvars ##
    ###################################################
    "

    jq -n '{  "project_id": $gcp_project, 
            "location": $gcp_location,
            "gke_name": $gke_name,
            "gke_nodepool": $gke_nodepool,
            "gke_machine_type": $gke_machine_type } ' \
        --arg gcp_project $GCP_PROJECT  \
        --arg gcp_location $GPC_LOCATION  \
        --arg gke_name $GKE_NAME  \
        --arg gke_nodepool $GKE_NODE_POOL \
        --arg gke_machine_type $GKE_MACHINE_TYPE \
        > terraform/terraform.tfvars.json

}

executeTerraformVariables () {
    echo "
    #########################################
    ## [5]. EJECUTAR COMANDOS DE TERRAFORM ##
    #########################################
    "

    ## TERRAFORM INIT
    cd terraform
    ./terraform.exe init

    ## TERRAFORM PLAN
    ./terraform.exe plan -var-file="terraform.tfvars.json"

    ## TERRAFORM APPLY
    ./terraform.exe apply -auto-approve

    ## TERRAFORM OUTPUT VARIABLES
    CLUSTER_NAME=($(./terraform.exe output name))
    CLUSTER_CA_CRT=($(./terraform.exe output cluster_ca_certificate))
    CLUSTER_ENDPOINT=($(./terraform.exe output endpoint))
    CLUSTER_MASTER_VERSION=($(./terraform.exe output master_version))

}

logInGpc () {
  echo "
  #########################################
  ## [6]. LOG IN AND CONFIGURE INTO GCP  ##
  #########################################
  "

  gcloud auth activate-service-account $GPC_CLIENT_MAIL --key-file=account.json --project=$GCP_PROJECT

  gcloud container clusters get-credentials $GKE_NAME --region $GPC_LOCATION

}

configureHelm() {
  echo "
  #######################################
  ## [7]. CONFIGURAR HELM Y EL INGRESS ##
  #######################################
  "

  ## INSTLACION DE HELM
  kubectl create serviceaccount --namespace kube-system tiller
  kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
  helm init --service-account tiller
  kubectl get deployments -n kube-system

  ## INSTALACION DE INGRESS
  helm install --name nginx-ingress stable/nginx-ingress --set rbac.create=true --set controller.publishService.enabled=true

}

createDockerImage () {
  echo "
  #######################################
  ## [8]. CREACION DE IMAGEN DE DOCKER ##
  #######################################
  "

  # Build Docker image
  cd ../python/src
  docker build -t pythonrest:latest .

  # Autenticar con GCR
  gcloud auth configure-docker

  # Subir la imagen a GCR
  docker tag pythonrest gcr.io/$GCP_PROJECT/mypythonapp

  docker push gcr.io/$GCP_PROJECT/mypythonapp

}

configureAuthGkeGcr () {
  echo "
  #############################################
  ## [9]. CONFIGURACION DE AUTH DE GKE Y GCR ##
  #############################################
  "

  cd ../../terraform
  kubectl create secret docker-registry regcred \
    --docker-server=https://gcr.io \
    --docker-username=_json_key \
    --docker-email=$GPC_CLIENT_MAIL \
    --docker-password="$(cat account.json)"

  kubectl patch serviceaccount default \
    -p "{\"imagePullSecrets\": [{\"name\": \"regcred\"}]}"

}

deploymetToGke () {
  echo "
  ##############################################
  ## [10]. DEPLOYMENT DE LA APLICACION AL GKE ##
  ##############################################
  "

  # CREAR DEPLOYMENT
  kubectl create deployment mypythonapp --image=gcr.io/$GCP_PROJECT/mypythonapp:latest

  # Exponer el service publicamente
  kubectl expose deployment mypythonapp --type=LoadBalancer --port 80 --target-port 5000

  echo "
  #################################
  ## [10]. DEPLOYMENT COMPLETADO ##
  #################################
  "
}

gpcVariableDefinition
terraformVariableDefinition
replaceGpcVariables
terraformInstallationByOs
replaceTerraformVariables
executeTerraformVariables
logInGpc
configureHelm
createDockerImage
configureAuthGkeGcr
deploymetToGke