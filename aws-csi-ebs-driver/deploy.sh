#!/bin/bash
check_status() {
  if [[ $1 != 0 ]]; then
    echo
    echo $2
    exit $1
  fi
}

CHART_NAME=aws-ebs-csi-driver
CHART_REPOSITORY=https://github.com/kubernetes-sigs/aws-ebs-csi-driver/releases/download/v0.5.0/helm-chart.tgz
CHART_NAMESPACE=kube-system
EXTRA_CMD='--atomic --cleanup-on-fail --reuse-values'

helm repo update
check_status $? 'Error when updating helm repos.'

helm upgrade --install ${CHART_NAME} ${CHART_REPOSITORY} --namespace ${CHART_NAMESPACE} \
  --set enableVolumeScheduling=true --set enableVolumeResizing=true --set enableVolumeSnapshot=true \
  ${EXTRA_CMD}
check_status $? 'Error when installing helm chart.'