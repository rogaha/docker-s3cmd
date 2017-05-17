#!/bin/sh -e

#
# main entry point to run s3cmd
#
S3CMD_PATH=/opt/s3cmd/s3cmd

#
# Check for required parameters
#
if [ -z "${AWS_ACCESS_KEY_ID}" ]; then
    echo "ERROR: The AWS_ACCESS_KEY_ID environment variable key is not set."
    exit 1
fi

if [ -z "${AWS_SECRET_ACCESS_KEY}" ]; then
    echo "ERROR: The AWS_SECRET_ACCESS_KEY environment variable secret is not set."
    exit 1
fi

if [ -z "${CMD}" ]; then
    echo "ERROR: The CMD environment variable cmd is not set."
    exit 1
fi

#
# Replace key and secret in the /.s3cfg file with the one the user provided
#
echo "" >> /.s3cfg
echo "access_key=${AWS_ACCESS_KEY_ID}" >> /.s3cfg
echo "secret_key=${AWS_SECRET_ACCESS_KEY}" >> /.s3cfg

# Chevk if we want to run in interactive mode or not
if [ "${CMD}" != "interactive" ]; then

  #
  # sync-s3-to-local - copy from s3 to local
  #
  if [ "${CMD}" = "sync-s3-to-local" ]; then
      echo ${src-s3}
      ${S3CMD_PATH} --config=/.s3cfg  sync ${SRC_S3} /opt/dest/
  fi

  #
  # sync-local-to-s3 - copy from local to s3
  #
  if [ "${CMD}" = "sync-local-to-s3" ]; then
      ${S3CMD_PATH} --config=/.s3cfg sync /opt/src/ ${DEST_S3}
  fi
else
  # Copy file over to the default location where S3cmd is looking for the config file
  cp /.s3cfg /root/
fi

#
# Finished operations
#
echo "Finished s3cmd operations"
