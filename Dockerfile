FROM docker/compose:1.29.2

ENV packages py-pip bash git openssh-client curl npm coreutils composer build-base

ARG DOCKER_VERSION

# Install defined packages
RUN apk add --no-cache $packages
RUN apk add python2-dev libffi-dev openssl-dev gcc libc-dev make

# install kubectl
RUN apk add -U openssl curl tar gzip bash ca-certificates git jq py-requests

# Install defined packages
RUN apk add --no-cache $packages
RUN pip install PyYAML


# Upgrade python-pip
RUN pip install --upgrade pip

# Install node-gyp
RUN npm config set unsafe-perm true
RUN npm install -g node-gyp

# Create ssh dir:
RUN mkdir -p ~/.ssh && chmod 700 ~/.ssh

# Strict Hostkey Setting
RUN echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

# Create helm config dir:
RUN mkdir -p /etc/helm-config

# Copy generic-helm-file to config location
#COPY ./config/ /etc/helm-config/

# Copy create_tag script to bin location
COPY ./scripts/ /usr/local/bin/
