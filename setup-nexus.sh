#!/usr/bin/env bash

docker run -d -u root -v $(pwd)/NexusData:/nexus-data -p 5000:5000 -p 8090:8081 --name nexus sonatype/nexus3
