s3cmd-util
============
[![GitHub forks](https://img.shields.io/github/forks/rogaha/s3cmd-util.svg)](https://github.com/rogaha/s3cmd-util/network)
[![GitHub stars](https://img.shields.io/github/stars/rogaha/s3cmd-util.svg)](https://github.com/rogaha/s3cmd-util/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/rogaha/s3cmd-util.svg)](https://github.com/rogaha/s3cmd-util/issues)
[![Docker Pulls](https://img.shields.io/docker/pulls/rogaha/s3cmd-util.svg)](https://hub.docker.com/r/rogaha/s3cmd-util/)
[![Docker Stars](https://img.shields.io/docker/stars/rogaha/s3cmd-util.svg)](https://hub.docker.com/r/rogaha/s3cmd-util/)

# Description

s3cmd in a Docker container.  This is useful if you are already using Docker.
You can simply pull this container to that Docker server and move things between the local box and S3 by just running
a container.

Using [Alpine linux](https://hub.docker.com/_/alpine/).  This image is 31MB.

You can find an automated build of this container on the Docker Hub: https://hub.docker.com/r/rogaha/s3cmd-util/

# Usage Instruction

## Copy from local to S3:

    AWS_KEY=<YOUR AWS KEY>
    AWS_SECRET=<YOUR AWS SECRET>
    S3_URL=s3://rogaha.public.S3_URL/database2/
    LOCAL_DIR=/tmp/database

    docker run \
    --env aws_key=${AWS_KEY} \
    --env aws_secret=${AWS_SECRET} \
    --env cmd=sync-local-to-s3 \
    --env DEST_S3=${S3_URL}  \
    -v ${LOCAL_DIR}:/opt/src \
    rogaha/s3cmd-util

* Change `LOCAL_DIR` to folder you want to upload to S3

## Copy from S3 to local:

    AWS_KEY=<YOUR AWS KEY>
    AWS_SECRET=<YOUR AWS SECRET>
    S3_URL=s3://bucket_name/tmp
    LOCAL_DIR=/tmp

    docker run \
    --env aws_key=${AWS_KEY} \
    --env aws_secret=${AWS_SECRET} \
    --env cmd=sync-s3-to-local \
    --env SRC_S3=${S3_URL} \
    -v ${LOCAL_DIR}:/opt/dest \
    rogaha/s3cmd-util

* Change `LOCAL_DIR` to the folder where you want to download the files from S3 to the local computer

## Run interactively with s3cmd

    AWS_KEY=<YOUR AWS KEY>
    AWS_SECRET=<YOUR AWS SECRET>

    docker run -it \
    --env aws_key=${AWS_KEY} \
    --env aws_secret=${AWS_SECRET} \
    --env cmd=interactive \
    -v /:/opt/dest \
    rogaha/s3cmd-util /bin/sh

Then execute the `main.sh` script to setup the s3cmd config file

    /opt/main.sh

Now you can run `s3cmd` commands

    s3cmd ls /
