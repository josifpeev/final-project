FROM ubuntu:22.04

RUN apt update; apt install openssh-server software-properties-common -y; add-apt-repository --yes --update ppa:ansible/ansible; apt install ansible -y; apt clean; apt autoremove
COPY .ssh /root/.ssh
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys

EXPOSE 22
