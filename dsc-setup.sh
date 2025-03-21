oc apply -f default-dsci.yaml
oc wait --for=jsonpath='{.status.phase}'=Ready dsci/default-dsci --timeout=300s

oc apply -f default-dsc.yaml
oc wait --for=jsonpath='{.status.phase}'=Ready dsc/default-dsc --timeout=300s
