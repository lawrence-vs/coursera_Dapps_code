FROM debian:trixie-20241202-slim

# Update and upgrade packages
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y openjdk-17-jre-headless \
  unzip curl procps vim net-tools aptitude \
  python3 python3-pip python3.12-venv

# We will put everything in the /app directory
WORKDIR /app
# Download and unzip client portal gateway
RUN mkdir gateway && cd gateway && \
  curl -O https://download2.interactivebrokers.com/portal/clientportal.gw.zip && \
  unzip clientportal.gw.zip && rm clientportal.gw.zip

# Copy our config so that the gateway will use it
COPY conf.yaml gateway/root/conf.yaml
COPY /app app
# COPY scripts/start.sh /app

# Expose the port so we can connect
EXPOSE 5055 5054

# Run the gateway
# CMD sh ./start.sh
