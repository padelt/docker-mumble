#!/bin/sh
docker run -d=true -p=64738:64738 -v=/docker-volumes/mumble:/data --name=mumble mumble
