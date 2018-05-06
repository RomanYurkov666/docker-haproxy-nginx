#!/bin/bash

# Start the nginx process
nginx -c /etc/nginx/nginx.conf
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start nginx: $status"
  exit $status
fi

# Start the second process
service haproxy start
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start haproxy: $status"
  exit $status
fi
