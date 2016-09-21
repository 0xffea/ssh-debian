FROM debian:8.6

WORKDIR /root

RUN apt update && \
    apt upgrade -y && \
    apt install -y \
        openssh-server \
        python2.7 \
        supervisor \
        vim \
        wget \
        unzip

COPY files/entrypoint.sh /root/
COPY files/sshd_config.tmpl /etc/confd/templates/
COPY files/sshd_config.toml /etc/confd/conf.d/
COPY files/supervisord.conf /etc/supervisor/conf.d/
COPY files/authorized_keys /root/.ssh/authorized_keys

RUN mkdir -p /var/run/sshd /var/log/supervisor && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22
ENTRYPOINT ["/root/entrypoint.sh"]
