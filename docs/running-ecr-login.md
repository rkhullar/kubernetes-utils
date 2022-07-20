## How to Automate ECR Login in Kubernetes

### Background
If you are trying to host an application in kubernetes with components in AWS, you might be using ECR for your container
images. This doc provides guidance for how to make the ECR -> K8S read integration easier.

Since docker login doesn't support IAM for ECR directly, we must generate temporary tokens that last 12 hours. The token
along with the registry url are stored as k8s `docker-registry` secret. Kubernetes pods can use that secret when they are
pulling container images. The config can be defined in the pod spec directly, or it can be defined in the service account.

### Prerequisites
1. secret for ECR service account credentials with the default names: `ecr_access_key` and `ecr_secret_key`
2. the service account IAM user should have permissions to read from ECR. for example:
   - `AmazonECSTaskExecutionRolePolicy`
   - `AmazonEKSFargatePodExecutionRolePolicy`

### Single Run
```shell
kubectl run -i --tty --rm test-ecr-login     \
  --image rkhullar/kubernetes-utils:0.1.0    \
  --env="KUBERNETES_TOKEN=$KUBERNETES_TOKEN" \
  --env="API_SERVER=$API_SERVER"             \
  --env="NAMESPACE=$NAMESPACE"               \
  --env="ECR_CREDS={ecr_cred_secret_name}"   \
  --env="ECR_LOGIN={ecr_login_secret_name}"  \
  --env="AWS_DEFAULT_REGION={ecr_region}"    \
  -- scripts/ecr-login.sh
```

### Scheduled Runs
TBD

### Links
- https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#add-imagepullsecrets-to-a-service-account
