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
    ```

- **[nfs-client-provisioner](https://github.com/helm/charts/tree/master/stable/nfs-client-provisioner)** 

    The NFS client provisioner is an automatic provisioner for Kubernetes that uses your already configured NFS server, automatically creating Persistent Volumes.

    Contains a deploy.sh file responsible for installing nfs-client-provisioner helm release on top of k8s cluster.

    Can be deployed by running the following command:
    ```
    #!/bin/bash
    ./deploy.sh storage-class-name foo.bar /volume/foo
    ```

- **[prometheus-operator](https://github.com/helm/charts/tree/master/stable/prometheus-operator)** 

    Installs prometheus-operator to create/configure/manage Prometheus clusters atop Kubernetes. This chart includes multiple components and is suitable for a variety of use-cases.

    Contains a deploy.sh file responsible for installing prometheus-operator helm release on top of k8s cluster.

- **prometheus-service-monitors** 

    Helm chart containing prometheus service monitor used in conjunction to prometheus operator to scrape metrics from external components, e.g: microservices, dynamically.

- **[cluster-autoscaler](https://github.com/helm/charts/tree/master/stable/cluster-autoscaler)** 

    The cluster autoscaler scales worker nodes within an AWS autoscaling group (ASG) or Spotinst Elastigroup. In this case,
    contains a deploy.sh file responsible for deploying the cluster-autoscaler artifacts using aws as the cloud provider.

- **[aws-csi-ebs-driver](https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html)** 

    The Amazon EBS Container Storage Interface (CSI) driver provides a CSI interface that allows Amazon EKS clusters to manage the lifecycle of Amazon EBS volumes for persistent volumes. The directory contains a deploy.sh file responsible to install the csi-ebs-driver through helm.

- **[aws-csi-efs-driver](https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html)** 

    The Amazon EFS Container Storage Interface (CSI) driver provides a CSI interface that allows Amazon EKS clusters to manage the lifecycle of Amazon EFS file systems. The directory contains a deploy.sh file responsible to install the csi-efs-driver through helm.

- **[metrics-server](https://github.com/helm/charts/tree/master/stable/metrics-server)** 

    [Metrics Server](https://github.com/kubernetes-incubator/metrics-server) is a cluster-wide aggregator of resource usage data. Resource metrics are used by components like `kubectl top` and the [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale) to scale workloads. To autoscale based upon a custom metric, see the [Prometheus Adapter chart](https://github.com/helm/charts/blob/master/stable/prometheus-adapter).