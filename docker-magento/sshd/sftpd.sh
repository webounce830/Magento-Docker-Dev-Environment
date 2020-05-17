#!/bin/sh

echo "root:$ROOT_PASSWORD" | chpasswd >/dev/null 2>&1

/usr/sbin/sshd -4 -D -e -p 2222 -o "ChrootDirectory $DIRECTORY"
