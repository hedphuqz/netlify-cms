#!/bin/bash

curl -sL https://raw.githubusercontent.com/IBM-Cloud/ibm-cloud-developer-tools/master/linux-installer/idt-installer | bash

# grab passwords
git clone "https://${GH_ACCESS_TOKEN}@github.ibm.com/munich-center/portfolio-website-external-passwords.git"
docker build -t $DOCKER_IMAGE_REPOSITORY_NAME .

ibmcloud plugin install -f code-engine
ibmcloud plugin install -f container-registry

ibmcloud login -r eu-de --apikey $IBMCLOUD_API_KEY
ibmcloud target -g portfolio-website
ibmcloud cr login

docker push $DOCKER_IMAGE_REPOSITORY_NAME
ibmcloud target -g portfolio-website -r eu-de
ibmcloud ce project select -n portfolio-website
ibmcloud ce application update -n portfolio-website-external