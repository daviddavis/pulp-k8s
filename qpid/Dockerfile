FROM fedora

RUN dnf -y update && dnf install -y python-qpid qpid-cpp-server qpid-cpp-server-linearstore && dnf clean all

EXPOSE 5672

ENTRYPOINT ["qpidd", "--auth=no"]
