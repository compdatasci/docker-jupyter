#!/bin/bash
# User can pass e.g. --env HOST_UID=1003 so that UID in the container matches
# with the UID on the host. This is useful for Linux users, Mac and Windows
# already do transparent mapping of shared volumes.
if [ "$HOST_UID" ]; then
    usermod -u $HOST_UID datacomputing
fi
if [ "$HOST_GID" ]; then
    groupmod -g $HOST_GID datacomputing
fi
# This makes sure that all files in /home/datacomputing are accessible by the user
# datacomputing. We exclude the folder ~/shared to reduce IO out to the host. Docker
# for Mac, Docker for Windows and the UID/GID trick above should mean that file
# permissions work seamlessly now.
find /home/datacomputing -maxdepth 1 | sed "1d" | grep -v "/home/datacomputing/shared" | xargs chown -R datacomputing:datacomputing 2> /dev/null || true
