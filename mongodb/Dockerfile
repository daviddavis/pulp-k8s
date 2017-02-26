FROM fedora

RUN dnf -y update && dnf -y install mongodb-server && dnf clean all

EXPOSE 27017

USER mongodb

ADD mongodb.conf /etc/mongodb.conf

ENTRYPOINT ["/usr/bin/mongod", "--quiet", "--config", "/etc/mongodb.conf", "run"]
