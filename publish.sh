#!/bin/bash

docker push zeathe/bravebrowser:$(cat version.txt)
docker tag zeathe/bravebrowser:$(cat version.txt) zeathe/bravebrowser:latest
docker push zeathe/bravebrowser:latest
