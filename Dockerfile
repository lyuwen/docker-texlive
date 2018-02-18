FROM ubuntu:xenial

LABEL Description="Dockerized TexLive, Ubuntu 16.04" Vendor="Lyuwen Fu" Version="1.0"

RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get install -y git wget scons ghostscript gsfonts

RUN git clone https://github.com/lyuwen/install-tl-ubuntu.git
RUN cd install-tl-ubuntu && bash install-tl-ubuntu --profile ${PWD}/example.profile
ENV PATH=/opt/texbin:${PATH}
RUN mkdir /workspace
WORKDIR /workspace

RUN tlmgr update --all
# RUN tlmgr install latexmk
# RUN tlmgr list | grep tikz | cut -d':' -f1 | xargs tlmgr install
 RUN tlmgr install standalone
# RUN tlmgr install arrayjobx epstopdf
