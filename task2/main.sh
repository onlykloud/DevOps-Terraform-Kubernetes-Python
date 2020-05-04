
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

    ## GCI NAME
    GCI_NAME="PUT_GCE_NAME_HERE"
    ## GKE NAME
    GCI_LOCATION="PUT_LOCATION_HERE"
    ## GKE MACHINE TYPE
    GKE_MACHINE_TYPE="PUT_MACHINE_TYPE_HERE"

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

    jq -n '{    "project_id": $gcp_project, 
                "gci_name": $gci_name, 
                "location": $gcp_location,
                "gke_machine_type": $gke_machine_type } ' \
        --arg gcp_project $GCP_PROJECT  \
        --arg gci_name $GCI_NAME  \
        --arg gcp_location $GCI_LOCATION  \
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
    VM_IP=($(./terraform.exe output ip))

}

gpcVariableDefinition
terraformVariableDefinition
replaceGpcVariables
terraformInstallationByOs
replaceTerraformVariables
executeTerraformVariables