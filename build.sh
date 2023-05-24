#!/bin/bash

docker build --tag zeathe/bravebrowser:$(cat version.txt) Build --no-cache
