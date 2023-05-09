FROM ubuntu:22.04
LABEL maintainer "Andy Schroder <info@AndySchroder.com>"

RUN apt update

RUN apt install -y iproute2 htop traceroute netcat wireguard iputils-ping iperf3 dnsutils python3-pip git net-tools vim

WORKDIR /StaticWireInstallers

ADD . /StaticWireInstallers

RUN pip3 install .

#change to the home directory. $HOME doesn't work, so manually set it to /root
WORKDIR /root

#remove installer files
RUN rm -r /StaticWireInstallers

