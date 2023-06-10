FROM registry.ballmerlabs.net/rusts:latest AS rustanalyzerbuild

FROM debian:stable-slim AS pythonbuild
ARG USER=user
ARG UID=10001
ARG VERSION=3.10.4
RUN apt update && apt install -y git curl build-essential libbz2-dev liblzma-dev \
 libreadline-dev libssl-dev zlib1g-dev libffi-dev libsqlite3-dev fish lzma-dev \
libglib2.0-dev libdbus-1-dev python3-dev
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&\
apt-get install -y nodejs
RUN npm install -g typescript-language-server typescript
COPY --from=rustanalyzerbuild /opt/cargo/bin/hx /bin/hx
RUN adduser --disabled-password --home "/home/${USER}" --uid ${UID} ${USER}
RUN mkdir -p /workspace && chown -R user:user /workspace
VOLUME /workspace
USER ${USER}
ENV HOME=/home/${USER}
WORKDIR /home/${USER}
COPY --from=rustanalyzerbuild /opt/helix/runtime $HOME/.config/helix/runtime
COPY --from=rustanalyzerbuild /root/.config/helix/config.toml $HOME/.config/helix/config.toml
ENV COLORTERM=truecolor
ENV TERM xterm-256color
WORKDIR /workspace
