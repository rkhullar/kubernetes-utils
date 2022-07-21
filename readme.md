## Kubernetes Utils

Provides the `kubectl` and `helm` commands package as an alpine docker image.

### Notes
#### local build
```shell
docker build -t k8s-util .
```

#### run container with shell
```shell
docker run --rm -it -e KUBERNETES_TOKEN -e API_SERVER -e NAMESPACE k8s-util
```

### Links
- https://blog.christianposta.com/kubernetes/logging-into-a-kubernetes-cluster-with-kubectl
