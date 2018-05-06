#!/bin/bash

# Start the nginx process
nginx -c /etc/nginx/nginx.conf
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start nginx: $status"
  exit $status
fi

# Start the second process
haproxy -f /etc/haproxy/haproxy.cfg
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start haproxy: $status"
  exit $status
fi
