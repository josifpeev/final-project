
FROM python:3.9.16-alpine

RUN apk update && apk add build-base libffi-dev openssl-dev openssh
RUN pip3 install ansible

COPY ansible /ansible
WORKDIR /ansible

CMD [ "ansible", "all" ]



#FROM python:3.7-alpine

#RUN apk update && apk add --no-cache openssh
#RUN pip install ansible

#COPY entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh

#ENTRYPOINT ["/entrypoint.sh"]






#FROM ubuntu:22.04

#RUN apt update; apt install openssh-server software-properties-common -y; add-apt-repository --yes --update ppa:ansible/ansible; apt install ansible -y; apt clean; apt autoremove
#COPY .ssh /root/.ssh
#RUN mkdir -p /run/sshd
#RUN chmod 700 /root/.ssh
#RUN chmod 600 /root/.ssh/authorized_keys

# EXPOSE 22
# Run commands to start the application
#CMD ["/usr/sbin/sshd", "-D"]