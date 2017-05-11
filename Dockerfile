FROM alpine:3.5

RUN apk update
RUN apk add python py-pip py-setuptools git ca-certificates
RUN pip install python-dateutil

RUN git clone https://github.com/s3tools/s3cmd.git /opt/s3cmd
RUN ln -s /opt/s3cmd/s3cmd /usr/bin/s3cmd

WORKDIR /opt

ADD ./src/s3cfg /opt/.s3cfg
ADD ./src/main.sh /opt/main.sh

# Main entrypoint script
RUN chmod 777 /opt/main.sh

# Folders for s3cmd optionations
RUN mkdir /opt/src
RUN mkdir /opt/dest

WORKDIR /
CMD ["/opt/main.sh"]
