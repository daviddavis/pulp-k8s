FROM fedora/apache

RUN dnf update -y && dnf install -y pulp-rpm-plugins pulp-docker-plugins pulp-ostree-plugins pulp-puppet-plugins pulp-python-plugins && dnf clean all

# this will be re-injected as a secret
RUN rm /etc/pulp/server.conf

RUN mkdir /mnt/pulp-config

# mounting a secret clobbers the whole directory. So we mount it elsewhere and
# symlink to it.
RUN ln -s /mnt/pulp-config/server.conf /etc/pulp/server.conf

ADD setup.sh /setup.sh

RUN dnf install -y python-qpid python-qpid-qmf qpid-tools && dnf clean all
RUN dnf install -y python-gofer-qpid && dnf clean all
