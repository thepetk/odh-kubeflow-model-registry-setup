oc apply -f nfd.yaml
oc wait --for=condition=available nodefeaturediscovery/nfd-instance --timeout=300s

sleep 15

oc get nodes -o yaml | grep feature.node.kubernetes.io/pci-10de.present

exit $?