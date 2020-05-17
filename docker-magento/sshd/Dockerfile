FROM alpine

ENV ROOT_PASSWORD=root
ENV DIRECTORY=/

RUN apk add --no-cache openssh-server openssh-sftp-server

COPY id_rsa /etc/ssh/ssh_host_rsa_key
COPY id_rsa.pub /root/.ssh/authorized_keys
COPY sftpd.sh /sftpd

RUN chmod 600 /etc/ssh/ssh_host_rsa_key && \
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
  #echo "ChrootDirectory /var/www/magento" >> /etc/ssh/sshd_config && \
  echo "ForceCommand internal-sftp" >> /etc/ssh/sshd_config && \
  echo "root:$ROOT_PASSWORD" | chpasswd && \
  chmod +x /sftpd && \
  #ln -s $DIRECTORY /root/magento && \
  echo

CMD ["/sftpd"]
#CMD ["/usr/sbin/sshd", "-D", "-E", "/dev/stderr", "-p", "2222"]
