#!/bin/bash
check_status() {
  if [[ $1 != 0 ]]; then
    echo
    echo $2
    exit $1
  fi
}

CHART_NAME=metrics-server
CHART_REPOSITORY=stable
CHART_VERSION=2.8.8
CHART_NAMESPACE=kube-system
EXTRA_CMD='--atomic --cleanup-on-fail --recreate-pods --reuse-values -f values.yaml'

helm repo update
check_status $? 'Error when updating helm repos.'

helm upgrade --install ${CHART_NAME} stable/metrics-server --version=${CHART_VERSION} \
  --namespace ${CHART_NAMESPACE} $EXTRA_CMD
check_status $? 'Error when installing helm chart.'