#!/bin/bash
oc apply -f ./authorino-rh-subscription.yaml
while true; do
	oc get csv -o name -n openshift-operators | grep authorino > autho.txt
	if [ -s autho.txt ]; then
		export AUTHORINO=$(cat autho.txt)
		echo "authorino csv is ${AUTHORINO}}"
		break
	else
		echo "autho.txt still emtpy"
		sleep 5
	fi
done
oc wait --for=jsonpath='{.status.phase}'=Succeeded "$AUTHORINO" -n openshift-operators --timeout=300s

oc apply -f ./servicemesh-subscription.yaml
while true; do
	oc get csv -o name -n openshift-operators | grep servicemesh > mesh.txt
	if [ -s mesh.txt ]; then
		export SERVICEMESH=$(cat mesh.txt)
		echo "servicemesh csv is ${SERVICEMESH}"
		break
	else
		echo "mesh.txt still emtpy"
		sleep 5
	fi
done
oc wait --for=jsonpath='{.status.phase}'=Succeeded "$SERVICEMESH" -n openshift-operators --timeout=300s


oc apply -f ./serverless-subscription.yaml

oc apply -f ./rhoai-subscription.yaml
while true; do
	oc get csv -o name -n redhat-ods-operator | grep rhods > hub.txt
	if [ -s hub.txt ]; then
		export RHODS=$(cat hub.txt)
		echo "hub csv is ${RHODS}"
		break
	else
		echo "hub.txt still empty"
		sleep 5
	fi
done
oc wait --for=jsonpath='{.status.phase}'=Succeeded "$RHODS" -n redhat-ods-operator --timeout=300s



