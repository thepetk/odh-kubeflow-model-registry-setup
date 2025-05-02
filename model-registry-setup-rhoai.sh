
oc apply -f mysql-db.yaml
oc project test-database 
oc wait --for=condition=available deployment/model-registry-db --timeout=5m

oc project rhoai-model-registries
oc apply -f registry-rhoai.yaml
oc wait --for=condition=available modelregistry.modelregistry.opendatahub.io/modelregistry-public --timeout=5m

oc apply -f rhods-admins.yaml

# should not be needed if your are on a cluster with cert mgmt like with ROSA
oc set env  deployment/odh-model-controller -n redhat-ods-applications MR_SKIP_TLS_VERIFY=true
oc wait --for=jsonpath='{.status.observedGeneration}'=2 deployment/odh-model-controller -n redhat-ods-applications --timeout=300s

URL=`echo "https://$(oc get routes -n istio-system -l app.kubernetes.io/name=modelregistry-public -o json | jq '.items[].status.ingress[].host | select(contains("-rest"))')" | tr -d '"'`
echo "model registry URL is ${URL}"
