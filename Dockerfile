ARG ALPINE_VERSION=3.16
FROM alpine:${ALPINE_VERSION}
ARG KUBE_VERSION=1.24.3
ARG HELM_VERSION=3.9.1

RUN apk add aws-cli bash bind-tools curl findutils jq nano zip

# intall kubectl
# NOTE: latest version can be inferred with $(curl -L -s https://dl.k8s.io/release/stable.txt)
RUN wget "https://dl.k8s.io/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl" \
    -O /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

# install helm
RUN wget "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" -O - \
    | tar xzO linux-amd64/helm > /usr/local/bin/helm && chmod +x /usr/local/bin/helm

ENV AUTO_CONFIG true
WORKDIR /root
COPY scripts/ scripts/

ENTRYPOINT ["/root/scripts/entrypoint.sh"]
CMD ["sh"]
