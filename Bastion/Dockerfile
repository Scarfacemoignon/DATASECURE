FROM debian:bullseye

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    openssh-server \
    nslcd nscd libnss-ldapd libpam-ldapd sudo \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

COPY sshd_config /etc/ssh/sshd_config
COPY nslcd.conf /etc/nslcd.conf
COPY nsswitch.conf /etc/nsswitch.conf

ENV LDAP_URI ldap://openldap
ENV LDAP_BASE dc=datasecure,dc=local

# Restrict nslcd.conf permissions
RUN chmod 600 /etc/nslcd.conf

CMD ["/usr/sbin/sshd", "-D"]
