oc apply -f cluster-policy.yaml
oc wait --for=jsonpath='{.status.state}'=ready clusterpolicy/gpu-cluster-policy --timeout=600s

oc get pods,daemonset -n nvidia-gpu-operator

oc project nvidia-gpu-operator

cat <<EOF | oc apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: gpu-pod
spec:
  restartPolicy: Never
  containers:
    - name: cuda-container
      image: nvcr.io/nvidia/k8s/cuda-sample:vectoradd-cuda12.5.0
      resources:
        limits:
          nvidia.com/gpu: 1 # requesting 1 GPU
  tolerations:
  - key: nvidia.com/gpu
    operator: Exists
    effect: NoSchedule
EOF

oc wait --for=jsonpath='{.status.phase}'=Succeeded pod/gpu-pod --timeout=600s

oc logs gpu-pod
