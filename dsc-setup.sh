oc apply -f default-dsci.yaml
sleep 5
oc wait --for=jsonpath='{.status.phase}'=Ready dsci/default-dsci --timeout=300s

oc apply -f default-dsc.yaml
sleep 5
oc wait --for=jsonpath='{.status.phase}'=Ready dsc/default-dsc --timeout=300s
