#!/bin/bash
check_status() {
	if [[ $1 != 0 ]]; then
		echo
		echo $2
		exit $1
	fi
}
CHART_NAME=prometheus-operator
CHART_REPOSITORY=stable
CHART_VERSION=8.1.2
CHART_NAMESPACE=monitoring
EXTRA_CMD='--atomic --cleanup-on-fail --recreate-pods'

helm repo update
check_status $? 'Error to update helm repositories'

helm upgrade --install $CHART_NAME $CHART_REPOSITORY/$CHART_NAME --version=$CHART_VERSION --namespace $CHART_NAMESPACE \
	--set prometheus.prometheusSpec.serviceMonitorNamespaceSelector.any=true --set grafana.enabled=true \
	--set prometheus.prometheusSpec.evaluationInterval=10s --set prometheus.prometheusSpec.scrapeInterval=10s \
	--set enableAdminAPI=false --set prometheus.serviceMonitor.interval=5s --set fullnameOverride=$CHART_NAME \
	$EXTRA_CMD
check_status $? 'Error to upgrade/install helm chart.'
