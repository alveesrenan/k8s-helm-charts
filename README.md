# [k8s-helm-charts](#https://helm.sh/)

This repo contains general helm charts created by common cases/scenarios. It acts like application bootstrap helm chart.

## **Project structure and usage**

It's composed by:

- **standard-application** 
    
    Standard helm chart which can be used for java, nodejs, kotlin microservices. It's composed by several `k8s articats`, such as:
    - **Deployment**
    - **Service**
    - **Persistent volume claim** using dynamic volume provisioning throught storage class (nfs, aws ebs.csi.driver, aws.efs.csi.driver, gcePersistentDisk, etc...)
    - **Secret**
    - **Ingress**
    - **Horizontal pod autoscaler**
    <br />

    Deploying the helm chart:
    ```bash
    #!/bin/bash
    check_status() {
    if [[ $1 != 0 ]]; then
        echo
        echo $2
        exit $1
    fi
    }
    CHART_NAME=standard-application
    CHART_REPOSITORY=YOUR_CHARTMUSEUM_ADDRESS | THE PACKAGE ITSELF
    CHART_VERSION=1.0.0
    CHART_NAMESPACE=default
    EXTRA_CMD='--atomic --cleanup-on-fail --recreate-pods'

    helm repo update
    check_status $? 'Error when updating helm repos.'

    helm upgrade --install ${CHART_NAME} ${CHART_REPOSITORY}/${CHART_NAME} --version=${CHART_VERSION} \
    --namespace ${CHART_NAMESPACE} $EXTRA_CMD
    check_status $? 'Error when installing helm chart.'