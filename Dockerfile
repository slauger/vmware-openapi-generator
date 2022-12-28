FROM registry.access.redhat.com/ubi8/ubi:8.6-855@sha256:68fecea0d255ee253acbf0c860eaebb7017ef5ef007c25bee9eeffd29ce85b29

LABEL maintainer="simon@lauger.de"

# Install requirements.
RUN sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/subscription-manager.conf \
 && yum makecache --timer \
 && yum -y install initscripts \
 && yum -y update \
 && yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
 && yum -y install \
      sudo \
      which \
      hostname \
      python39 \
      python39-devel \
      python39-pip \
      git \
      wget \
      curl \
      jq \
      pwgen \
      unzip \
      bind-utils \
      ca-certificates \
      openssh \
      openssl-libs \
      make \
      openssl-devel \
      libffi-devel \
 && yum clean all \
 && rm -rf /var/cache/dnf/*

# Python Dependencies
RUN pip3 install -U pip && \
    pip3 install pipenv && \
    pip install --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git && \
    cd /opt && \
    git clone https://github.com/vmware/vmware-openapi-generator.git

# Create workspace
RUN mkdir /workspace
WORKDIR /workspace
