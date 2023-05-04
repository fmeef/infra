from registry.ballmerlabs.net/rusts:latest
ARG UID=10000
ARG GID=10000
ENV HOME=/home/user
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y  libssl-dev \
  build-essential git python3-dev python3-pip wget sudo clangd

COPY FBT-AARCH64 /opt/FBT-AARCH64
RUN echo y | bash /opt/FBT-AARCH64/setup.sh

RUN  addgroup --gid ${GID} user && \
    adduser --uid ${UID} --gid ${GID} --home /home/user --gecos "" --disabled-password user && \
    mkdir -p /home/user/.config/fish && chown -R user:user /home/user && \
    chown -R user:user /opt/ && chown -R user:user /usr/local && \
    mkdir -p /workspace/target && chown -R user:user /workspace && \
    mkdir -p /home/user/.config && cp -Rv /root/.config/helix /home/user/.config/helix && \
    chown -R user:user /home/user/.config/helix

RUN python3 -m pip install --upgrade ufbt
USER user

ENV COLORTERM=truecolor
ENV TERM xterm-256color
RUN git config --global --add safe.directory /workspace
WORKDIR /workspace
CMD [ "/usr/bin/fish" ]


