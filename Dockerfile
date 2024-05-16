FROM alpine:3.18.4

LABEL maintainer="EDP Team"

ENV KUBECTL_VERSION=1.28.4 \
    OPENSSH_VERSION=9.3_p2-r1 \
    TKN_VERSION=0.33.0 \
    PYTHON_VERSION=3.11 \
    PIP_VERSION=23.1.2-r0 \
    JQ_VERSION=1.6 \
    YQ_VERSION=4.33.3-r5 \
    BASH_VERSION=5.2.15 \
    CURL_VERSION=8.5.0-r0 \
    ARCH=amd64 \
    OS=Linux_x86_64

# Install dependencies
RUN apk add --update --no-cache \
    jq~=${JQ_VERSION} \
    yq~=${YQ_VERSION} \
    bash~=${BASH_VERSION} \
    curl~=${CURL_VERSION} \
    python3~=${PYTHON_VERSION} \
    py3-pip~=${PIP_VERSION} \
    openssh-keygen~=${OPENSSH_VERSION}

RUN curl -sLO "https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin

RUN curl -LO "https://github.com/tektoncd/cli/releases/download/v${TKN_VERSION}/tkn_${TKN_VERSION}_${OS}.tar.gz" \
    && tar zxvf tkn_${TKN_VERSION}_Linux_x86_64.tar.gz -C /usr/local/bin tkn \
    && rm -f tkn_${TKN_VERSION}_Linux_x86_64.tar.gz
