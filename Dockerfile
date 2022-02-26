FROM ubuntu:latest

LABEL Description="Dockerized TexLive, Ubuntu 20.04" Vendor="Lyuwen Fu" Version="1.1"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      time \
      sudo \
      git \
      wget \
      scons \
      ghostscript \
      gsfonts \
      lsb-release \
      python3-requests \
      python3-bs4 \
      python3-lxml \
      && rm -rf /var/lib/apt/lists/*

ARG NB_USER=tester
ARG NB_UID=1000
RUN useradd -u $NB_UID -m $NB_USER --shell /bin/bash && \
    echo 'tester ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER $NB_USER
WORKDIR /home/$NB_USER
COPY texlive.profile /home/$NB_USER/texlive.profile
RUN git clone https://github.com/lyuwen/install-tl-ubuntu.git && \
    cd install-tl-ubuntu && \
    sudo apt-get update && \
    sudo bash install-tl-ubuntu --profile /home/$NB_USER/texlive.profile \
    && sudo rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/texbin:${PATH}
RUN sudo mkdir /workspace && sudo chown $NB_USER:$NB_USER /workspace
WORKDIR /workspace

# RUN tlmgr update --all
# RUN tlmgr install latexmk
# RUN tlmgr list | grep tikz | cut -d':' -f1 | xargs tlmgr install
# RUN tlmgr install standalone
# RUN tlmgr install arrayjobx epstopdf
