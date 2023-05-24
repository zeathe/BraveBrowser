FROM jlesage/baseimage-gui:ubuntu-20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl
RUN curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|tee /etc/apt/sources.list.d/brave-browser-release.list

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y brave-browser

RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN useradd -d /home/brave -m brave

COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh
