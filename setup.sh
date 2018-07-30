#!/bin/bash

function extractAgentAutoRegistryKey {
    echo $(grep 'agentAutoRegisterKey' GoServerData/config/cruise-config.xml | awk -F"agentAutoRegisterKey=\"" '{print $2}' | awk -F"\" webhookSecret" '{print $1}')
}

function waitUntilGoServerStarts {
    while ! grep -q agentAutoRegisterKey GoServerData/config/cruise-config.xml; do
        echo 'Go server startup in progress'
        sleep 5
    done
    extractAgentAutoRegistryKey
}

function startGoAgent {
    CONTAINER_ID=$(docker run -d \
    --net=host \
    -e WORKDIR=$(pwd)/GoAgentData \
    -e GO_SERVER_URL=https://localhost:8154/go \
    -v $(pwd)/GoAgentData:/godata \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e AGENT_AUTO_REGISTER_KEY=$(extractAgentAutoRegistryKey) \
    -e AGENT_AUTO_REGISTER_RESOURCES=docker \
    -e AGENT_AUTO_REGISTER_HOSTNAME=agent1 \
    goagent-with-docker:latest) && docker exec -i -u root $CONTAINER_ID chmod 666 /var/run/docker.sock
}

function startGoServer {
    docker run -d \
    -v $(pwd)/GoServerData:/godata \
    -v $HOME:/home/go \
    -p8153:8153 -p8154:8154 \
    gocd/gocd-server:v18.6.0
}

#docker pull gocd server and agent image
docker pull gocd/gocd-agent-ubuntu-16.04:v18.7.0
docker pull gocd/gocd-server:v18.7.0

#docker build go agent with docker and rancher compose
docker build -t goagent-with-docker:latest .

#start docker server and agent
startGoServer \
&& waitUntilGoServerStarts \
&& echo "go server started" \
&& startGoAgent \
&& echo "go agent started"

echo "setting pipeline as code"
./pipeline-as-code.sh
