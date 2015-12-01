# Builds a basic docker image that can run Mumble
#
# Author: Isaac Bythewood
# Edited by: Programster [ http://programster.blogspot.co.uk/ ]
# Edited by: Philipp Adelt
# Updated: 2015-12-01
# -----------------------------------------------------------------------------


# Base system is the LTS version of Ubuntu.
FROM ubuntu:14.04

MAINTAINER padelt

# Make sure we don't get notifications we can't answer during building.
ENV DEBIAN_FRONTEND noninteractive

# Download and install everything from the repos.
ADD apt-7F05CF9E.key /tmp/apt-7F05CF9E.key
RUN apt-key add /tmp/apt-7F05CF9E.key
RUN echo "deb http://ppa.launchpad.net/mumble/release/ubuntu trusty main" > /etc/apt/sources.list.d/mumble.list
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install mumble-server supervisor pwgen -y

# Load in all of our config files.
ADD mumble /home/mumble
ADD supervisor /etc/supervisor
RUN cp -f /home/mumble/mumble-server.ini /etc/mumble-server.ini

# Fix all permissions
RUN chmod +x /home/mumble/startup.sh

# 80 is for nginx web, /data contains static files and database /start runs it.
EXPOSE 64738
VOLUME ["/data"]
CMD    ["/home/mumble/startup.sh"]

