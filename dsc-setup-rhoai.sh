# RHOAI install seems to create a DSCI now, so let's jut make sure it is ready
while true; do
  oc get dsci default-dsci > dsci.txt
  if [ -s dsci.txt ]; then
    echo "dsci is present"
    break
  else
    echo "still waiting on dsci"
  fi
done
oc wait --for=jsonpath='{.status.phase}'=Ready dsci/default-dsci --timeout=300s

sleep 5

oc apply -f default-dsc-rhoai.yaml
sleep 5
oc wait --for=jsonpath='{.status.phase}'=Ready dsc/default-dsc --timeout=300s
