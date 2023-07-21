FROM ubuntu:22.04
LABEL maintainer "Andy Schroder <info@AndySchroder.com>"

RUN apt update

# allow resolvconf to be installed properly in docker since wg-quick wants it.
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

RUN apt install -y iproute2 htop traceroute netcat wireguard iputils-ping iperf3 dnsutils python3-pip git net-tools vim libsystemd-dev pkg-config resolvconf

WORKDIR /StaticWireInstallers

ADD . /StaticWireInstallers

RUN pip3 install .

#change to the home directory. $HOME doesn't work, so manually set it to /root
WORKDIR /root

#remove installer files
RUN rm -r /StaticWireInstallers

# since StaticWire has bad habbits and doesn't conform to PEP8, modify vi's settings to use tabs instead of spaces
RUN mkdir -p /root/.vim/after/ftplugin/
RUN echo "set noexpandtab">/root/.vim/after/ftplugin/python.vim




