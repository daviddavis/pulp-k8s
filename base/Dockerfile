FROM fedora/apache

RUN dnf update -y && dnf install -y pulp-rpm-plugins pulp-docker-plugins \
    pulp-ostree-plugins pulp-puppet-plugins pulp-python-plugins \
    python-qpid python-qpid-qmf qpid-tools python-gofer-qpid && dnf clean all

# this will be re-injected as a secret
RUN rm /etc/pulp/server.conf

# mounting a secret clobbers the whole directory. So we mount it elsewhere and
# symlink to it.
RUN ln -s /var/run/secrets/pulp/pulp-config/server.conf /etc/pulp/server.conf

ADD setup.sh /setup.sh
