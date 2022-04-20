ARG ARGOCD_VERSION
FROM argoproj/argocd:v${ARGOCD_VERSION}

ARG SOPS_VERSION
ARG HELM_SECRETS_VERSION

USER root
COPY helm-wrapper.sh /usr/local/bin/
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe" && \
    apt-get update && \
    apt-get install -y \
    curl \
    gpg \
    age && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    curl -o /usr/local/bin/sops -L https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux && \
    chmod +x /usr/local/bin/sops && \
    cd /usr/local/bin && \
    mv helm helm.bin && \
    mv helm2 helm2.bin && \
    mv helm-wrapper.sh helm && \
    ln helm helm2 && \
    chmod +x helm helm2

# helm secrets plugin should be installed as user argocd or it won't be found
USER argocd
RUN /usr/local/bin/helm.bin plugin install https://github.com/jkroepke/helm-secrets
ENV HELM_PLUGINS="/home/argocd/.local/share/helm/plugins/"
