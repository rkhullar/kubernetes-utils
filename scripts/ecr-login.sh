#!/usr/bin/env sh

ECR_CREDS_ACCESS_KEY=${ECR_CREDS_ACCESS_KEY:-ecr_access_key}
ECR_CREDS_SECRET_KEY=${ECR_CREDS_SECRET_KEY:-ecr_secret_key}

AWS_ACCESS_KEY_ID=$(kubectl get secret "$ECR_CREDS" -o jsonpath="{.data.${ECR_CREDS_ACCESS_KEY}}" | base64 -d)
AWS_SECRET_ACCESS_KEY=$(kubectl get secret "$ECR_CREDS" -o jsonpath="{.data.${ECR_CREDS_SECRET_KEY}}" | base64 -d)
# NOTE verify AWS_REGION?

AWS_ACCOUNT_ID=$(aws aws sts get-caller-identity | jq -r '.Account')
ECR_TOKEN=$(aws ecr get-login-password)
