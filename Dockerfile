FROM registry.tanzu.vmware.com/tanzu-application-platform/tap-packages@sha256:681ef8d2e6fc8414b3783e4de424adbfabf2aa0126e34fa7dcd07dab61e55a89
ARG KIND_VERSION="v0.12.0"
# All the direct Downloads need to run as root as they are going to /usr/local/bin
USER root
# TMC
RUN curl -L -o /usr/local/bin/tmc $(curl -s https://tanzupaorg.tmc.cloud.vmware.com/v1alpha/system/binaries | jq -r 'getpath(["versions",.latestVersion]).linuxX64') && \
    chmod 755 /usr/local/bin/tmc
# Policy Tools
RUN curl -L -o /usr/local/bin/opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64 && \
    chmod 755 /usr/local/bin/opa
# Tanzu
# RUN curl -o /usr/local/bin/tanzu https://storage.googleapis.com/tanzu-cli/artifacts/core/latest/tanzu-core-linux_amd64 && \
#     chmod 755 /usr/local/bin/tanzu

# Knative
RUN curl -L -o /usr/local/bin/kn https://github.com/knative/client/releases/download/knative-v1.1.0/kn-linux-amd64 && \
    chmod 755 /usr/local/bin/kn
# Utilities
RUN apt-get update && apt-get install -y unzip sudo
RUN apt-get upgrade -y
RUN curl -H "Accept: application/vnd.github.v3.raw" \
    -L https://api.github.com/repos/vmware-tanzu/community-edition/contents/hack/get-tce-release.sh | \
    bash -s v0.10.0 linux
#RUN adduser -D -u 1001 eduk8s -g root
RUN gpasswd -a eduk8s sudo 

# TCE

RUN tar xzvf tce-linux-amd64-v0.10.0.tar.gz
COPY install-tce.sh tce-linux-amd64-v0.10.0/
RUN cd tce-linux-amd64-v0.10.0 && chmod +x ./install-tce.sh && ./install-tce.sh
RUN chown -R eduk8s /home/eduk8s 

RUN gpasswd -a eduk8s docker 
RUN echo 'eduk8s  ALL=(ALL) /bin/su' >>  /etc/sudoers
#RUN newgrp docker
#RUN adduser --uid 1001 --group root
RUN curl -Lso /usr/bin/kind "https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-linux-amd64" && \
    chmod +x /usr/bin/kind
# RUN curl -s -L "https://github.com/loft-sh/vcluster/releases/latest" | sed -nE 's!.*"([^"]*vcluster-linux-amd64)".*!https://github.com\1!p' | xargs -n 1 curl -L -o vcluster && chmod +x vcluster;
# RUN mv vcluster /usr/local/bin;
USER 1001