## How to Obtain the Kubernetes Token

### Tiller Service Account
```shell
export TOKEN_NAME="$(kubectl get sa tiller -o jsonpath='{.secrets[0].name}')"
export KUBERNETES_TOKEN="$(kubectl get secret ${TOKEN_NAME} -o jsonpath='{.data.token}' | base64 --decode && echo)"
```
