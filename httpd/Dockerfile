FROM pulp/base

EXPOSE 80 443

RUN rm /etc/pki/tls/certs/localhost.crt && ln -s /mnt/httpd-cert/httpd.crt /etc/pki/tls/certs/localhost.crt

RUN rm /etc/pki/tls/private/localhost.key && ln -s /mnt/httpd-cert/httpd.key /etc/pki/tls/private/localhost.key

RUN mkdir /mnt/httpd-cert && chmod 700 /mnt/httpd-cert
