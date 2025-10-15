FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y openssh-server sudo curl net-tools

RUN useradd -m -s /bin/bash ansible && \
    echo "ansible:password" | chpasswd && \
    adduser ansible sudo && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

RUN mkdir -p /var/run/sshd /run/sshd

RUN ssh-keygen -A
RUN mkdir -p /home/ansible/.ssh
COPY ansible_key.pub /home/ansible/.ssh/authorized_keys
RUN chown -R ansible:ansible /home/ansible/.ssh && \
    chmod 700 /home/ansible/.ssh && \
    chmod 600 /home/ansible/.ssh/authorized_keys

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]