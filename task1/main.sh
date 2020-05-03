
gpcVariableDefinition () {
    echo "
    #############################################################
    ## [1]. DEFINICION DE VARIABLES DEL SERVICE ACCOUNT DE GCP ##
    #############################################################
    "
    ## GCP Project Name - Ejemplo: devops-manuel
    GCP_PROJECT="devop-manu"
    ## GCP Private Key ID - Ejemplo: 282b19cf817f43240aw984feaca8623aa29af233
    GPC_PRIVATE_KEY_ID="282b19cf817f43240af984feaca86b3aa29af233"
    ## GCP Private Key - Ejemplo: -----BEGIN PRIVATE KEY-----\-----END PRIVATE KEY-----\n
    GPC_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC8RCHSOBA2vvf9\n5n1TpPfyk5g/ksS/YsuA8efwCm0VzHKGu6Lkyt4Krz22qVYMwrkkdH2FZVC9osVH\nZ9R2Mj6FxEyGb869dPLJfifZ0q3vU3Tdo/rP8895XaZuAKlNoydEn40xZ0Tu62PM\n/aeahvQvxlPq3gbPbRw72YeinMlUnBiJHeojYL61DSKSwmMQjXvr5lspvfENwW8G\n0CnrBzc+4Pa/hTtjr38FNQLc0zcuO15BG8eY3p94yOJ6hz3bR0T9lRYBEzP8rUAd\nFs48bqSPdUVMreOehAoc76XbQmxmXAPCQAecwvuw0PzwlV0+dERNtqWGuDKIU5Kg\nUy0LzcaXAgMBAAECggEABdyXMvzk4Fd80C5ze3247JgU1vHiZ1UTof2mK46fi9y0\nOiawcTAxzqJbKQtHrxkG+7AW0mbvpx/gxZLhhhaVZMPSYCMuDC8OeiCP7BPHr5pp\nGpeG8R+Vt6EnU+h4XP7184iGNGITPt8cWd8R71lBVBV4OmlUS/QJO4HP28vG5vfx\ncETkdojsxa78yXcvyefncDQXfp/yY/j6P2r5PrIURAicORHmVSFTh72LVjUb4xTw\nFu8xTqcPij8KdwHTzt5xqQb1cI7T9j8VpXiutHO5APWcothRy++jWfWd3r+E23r1\nucfLJMsUcou+zeSUNTOWW5pyNJ+qDM7qgrdOeT97lQKBgQD6Bv2IMJZ87apIabCl\nVUbVUbFrUXwEQsiWwjJvCxYk0ARLVKtTTXhjz6FNAM99kdmySyARZtSLQGfj+Hkz\nXrY7Ve4qrqEmluH/5H3littaxNziEFiB67zQgeSkMULVCSdmsdqbbgxwGFzZadWA\nkLabhJt0oLGfdwzmcRcDpyxP6wKBgQDAw3MIAMr4n1T+HEaXJCLJ9+vU+CGuEsBc\nQ7XMOsvgzLiha7bKSVHvOjWrOf2Q0AeyH9nuzA6yYtY1pDS0pc+jaLgcgAQ1yUcH\nsdAGuWz3R2m0adFxeWOC7KiKzuW7v1Z2NEZxkPuEjdQCMxUpbLdA4Zhsa5f1zrld\ngT7l45nlBQKBgGA4Mnen4zIesIp/igiGgeT0NGgNisGFBfbms0wCozn1h8GJywka\n5jrbG8Mrja5QY8v2l1e7EA6q8ZBM/i+jwlOhZS+t1ryoEj9NKpoczv/mhO7GxZjy\nJM7FPj1l68daZ3xg87UfK9Azv/+3d/+rMWs2JDFE6jZpNWC1otq4ChiTAoGBAL7P\negmdB03uImrbwICSM6GrORX6fRRb2XA7UjUUqoYfAFBBWJKK24EsJL4WzEpRspx+\n7PJ1qcKpFZPJtKZxT8VYvo7vpbs8P4R9XgeZ+yQX26nL6Zgi6f9Klle5EC217Ddb\n7bMzKdX/srJusG7t/8RIy+He63BVrqXBb2qOzuKlAoGBAPSgitYkwV3Ly3BtdaO9\nP8jCjRNdWYnRyXypMpFlhsHH3Pq3jGpHhqCNbEmkqT8gGk0eoqz5vxH1cMM76ozQ\nOyYTNTGs4N83g8p1AeOgWY5DLMLxa8W6zXJhfSeuj54mpDA1uUaFaLMZlJO07Eik\nPDdb8sxOZUsKcVB+oe9gE/QX\n-----END PRIVATE KEY-----\n"
    ## GCP Client Email - Ejemplo: gcp-devops@devop-manu.iam.gserviceaccount.com
    GPC_CLIENT_MAIL="gcp-devops@devop-manu.iam.gserviceaccount.com"
    ## GCP Client ID - Ejemplo: 106512508332840639292
    GPC_CLIENT_ID="106512502332840639292"
    ## GCP CLIENT X509 CERT URL - Ejemplo: https://www.googleapis.com/robot/v1/metadata/x509/gcp-devops%40devop-manu.iam.gserviceaccount.com
    GPC_CLIENT_CERT_URL="https://www.googleapis.com/robot/v1/metadata/x509/gcp-devops%40devop-manu.iam.gserviceaccount.com"

}

terraformVariableDefinition () {
    echo "
    #################################################
    ## [1.1]. DEFINICION DE VARIABLES DE TERRAFORM ##
    #################################################
    "

    ## GPC LOCATION
    GPC_LOCATION="us-central1-a"
    ## GKE NAME
    GKE_NAME="cluster-manu"
    ## GKE NODE POOL NAME
    GKE_NODE_POOL="cluster-nodepool"
    ## GKE MACHINE TYPE
    GKE_MACHINE_TYPE="n1-standard-1"

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