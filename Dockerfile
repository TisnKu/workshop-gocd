FROM gocd/gocd-agent-ubuntu-16.04:v18.7.0
COPY rancher-compose-install.sh /opt
WORKDIR /opt
RUN curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh && rm get-docker.sh
RUN usermod -aG docker go
RUN chmod +x rancher-compose-install.sh && ./rancher-compose-install.sh 0.12.5
