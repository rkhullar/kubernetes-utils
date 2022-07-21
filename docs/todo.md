## Future Work
- refactor `api_server` to `kubernetes_host`
- add parameter verification and error handling in scripts
- create helm charts for `ecr-login`
- upgrade image to aws cli v2
- try irsa instead of aws iam user for ecr

### aws cli v2
- currently hard to install on alpine based docker images
- options:
  - wait until alpine support is added
  - change base image
  - stay with aws cli v1

### without upgrading aws cli
- reduce repetition in helper script
  - make function for parsing docker login command
  - or have python print sh assignments and have caller source output

### trying irsa for `ecr-login`
- create aws iam role with permissions to read from ecr
- create k8s service account linked to role
- add branching in script to use either the service account or `ecr_cred_secret_name`
