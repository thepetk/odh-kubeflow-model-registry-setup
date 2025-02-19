# Set up of OpenDataHub (midstream for RHOAI) with KubeFlow (one of the upstreams of RHOAI) for RHDH AI Model Catalog testing

Latest functional testing shows you need OCP 4.16 or greater. 

## Install via kustomize

From a clone of this repo, run from the same directory as this README:

```shell
oc apply -k ./kustomize/
```

## Remove kustomization installation resources after successful ODH/ModelRegistry installation (but don't remove ODH isntallation)

Either run:

```shell
oc delete -k ./kustomize/
```

or run
```shell
oc delete ns odh-kubeflow-model-registry-setup
oc delete clusterrolebinding odh-kubeflow-model-registry-setup
```

## If we have the need to parameterize frequently ...

We'll look into helm charts.

## References

- [OpenDataHub Manual Model Registry instructions](https://github.com/opendatahub-io/model-registry-operator/blob/main/docs/install.md#installation-of-model-registry-terminal-based)
- [OCP 4.16 Serverless Install via CLI](https://docs.openshift.com/serverless/1.35/install/install-serverless-operator.html#serverless-install-cli_install-serverless-operator)