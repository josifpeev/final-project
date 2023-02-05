
FROM python:3.9.16-alpine

RUN apk update && apk add build-base libffi-dev openssl-dev openssh
RUN pip3 install ansible

COPY ansible /ansible
WORKDIR /ansible

CMD [ "ansible", "all" ]
