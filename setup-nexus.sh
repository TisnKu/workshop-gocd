#!/usr/bin/env bash

docker run -d -v $(pwd)/NexusData:/nexus-data -p 5000:5000 -p 9091:8081 --name nexus sonatype/nexus3
