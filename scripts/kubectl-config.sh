#!/usr/bin/env sh
kubectl config set-credentials cli/k8s --token "${KUBERNETES_TOKEN}"
kubectl config set-cluster k8s --server "${API_SERVER}"
kubectl config set-context default/k8s/cli --user=cli/k8s --namespace="${NAMESPACE}" --cluster=k8s
kubectl config use-context default/k8s/cli
