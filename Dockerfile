FROM gocd/gocd-agent-ubuntu-16.04:v18.6.0
COPY rancher-compose-install.sh /opt
RUN apt-get update && apt-get install -y docker.io
WORKDIR /opt
RUN usermod -a -G docker go
RUN chmod +x rancher-compose-install.sh && ./rancher-compose-install.sh 0.12.5
