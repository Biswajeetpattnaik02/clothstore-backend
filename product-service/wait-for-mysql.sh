#!/bin/sh

echo "Waiting for MySQL at $1:$2..."

while ! nc -z "$1" "$2"; do
  sleep 1
done

echo "MySQL is up - continuing..."
exec "$@"
