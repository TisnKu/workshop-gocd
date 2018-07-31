#!/usr/bin/env bash

docker run -d -u root -v $(pwd)/NexusData:/nexus-data -p 8081:8081 --name nexus sonatype/nexus3
