#!/usr/bin/env bash

docker run -d -u root -v $(pwd)/NexusData:/nexus-data -p 8090:8081 --name nexus sonatype/nexus3
