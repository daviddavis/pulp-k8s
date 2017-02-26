FROM fedora

RUN dnf -y update && dnf install -y python-qpid qpid-cpp-server qpid-cpp-server-linearstore && dnf clean all

EXPOSE 5671

ADD qpidd.conf /etc/qpid/qpidd.conf

ENTRYPOINT ["qpidd", "--config=/etc/qpid/qpidd.conf"]
