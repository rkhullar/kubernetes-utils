#!/usr/bin/env sh

# TODO: verify ECR_CREDS ECR_LOGIN and AWS_DEFAULT_REGION; try aws cli v2

ECR_CREDS_ACCESS_KEY=${ECR_CREDS_ACCESS_KEY:-ecr_access_key}
ECR_CREDS_SECRET_KEY=${ECR_CREDS_SECRET_KEY:-ecr_secret_key}

export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
AWS_ACCESS_KEY_ID=$(kubectl get secret "$ECR_CREDS" -o jsonpath="{.data.${ECR_CREDS_ACCESS_KEY}}" | base64 -d)
AWS_SECRET_ACCESS_KEY=$(kubectl get secret "$ECR_CREDS" -o jsonpath="{.data.${ECR_CREDS_SECRET_KEY}}" | base64 -d)

# AWS_ACCOUNT_ID=$(aws sts get-caller-identity | jq -r '.Account') # NOTE: will need in aws cli v2
export DOCKER_LOGIN_CMD
DOCKER_LOGIN_CMD=$(aws ecr get-login --no-include-email) # NOTE: changes in aws cli v2
ECR_TOKEN=$(python3 -c "import os; cmd=os.environ['DOCKER_LOGIN_CMD']; cmd_arr=cmd.split(' '); print(cmd_arr[5])")
ECR_URL=$(python3 -c "import os; cmd=os.environ['DOCKER_LOGIN_CMD']; cmd_arr=cmd.split(' '); print(cmd_arr[6])")
unset DOCKER_LOGIN_CMD

# TODO: try upserting secret instead of recreating
kubectl delete secret "$ECR_LOGIN" || true
kubectl create secret docker-registry "$ECR_LOGIN" --docker-server="$ECR_URL" --docker-username="AWS" --docker-password="$ECR_TOKEN"
