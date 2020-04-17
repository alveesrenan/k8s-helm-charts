#!/bin/bash
check_status() {
  if [[ $1 != 0 ]]; then
    echo
    echo $2
    exit $1
  fi
}
CHART_NAME=nfs-client-provisioner
CHART_REPOSITORY=stable
CHART_VERSION=1.2.8
CHART_NAMESPACE=default
EXTRA_CMD='--atomic --cleanup-on-fail'

helm repo update
check_status $? 'Error when pushing helm chart.'

### Install an nfs-client-provisioner (@see: https://github.com/helm/charts/tree/master/stable/nfs-client-provisioner)
### $1= storage class name, $2= nfs server, $3= nfs.path
### e.g: bash deploy.sh foo nfs.server /volume/foo
helm upgrade --install $CHART_NAME $CHART_REPOSITORY/$CHART_NAME --version=$CHART_VERSION --namespace $CHART_NAMESPACE \
  --set storageClass.name=$1 --set nfs.server=$2 --set nfs.path=$3 $EXTRA_CMD
check_status $? 'Error to upgrade/install helm chart.'
