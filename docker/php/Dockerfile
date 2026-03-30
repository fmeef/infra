FROM registry.ballmerlabs.net/rusts:latest AS rustanalyzerbuild

# Temporary builder image for rust toolchain
FROM composer:latest AS rustbuild
RUN apk update && apk add git fish curl alpine-sdk openssl-dev
ENV RUSTUP_HOME=/opt/rustup
ENV CARGO_HOME=/opt/cargo
ENV PATH="${PATH}:${CARGO_HOME}/bin"
env CARGO_NET_GIT_FETCH_WITH_CLI=true
RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y && \
    rustup component add rust-src && rustup target add aarch64-unknown-linux-musl


ARG USER=user
ARG UID=10001

RUN adduser -D -h "/home/${USER}" -u ${UID} ${USER}

ENV HOME=/home/${USER}

RUN git clone https://github.com/helix-editor/helix /opt/helix && \
    cd /opt/helix && \
#    git checkout 22.12 && \
    rustup override set stable && \
     CFLAGS=-mno-outline-atomics cargo install --locked --path helix-term && cargo clean && \
    mkdir -p /root/.config/helix && \
    mkdir -p $HOME/.config/helix/ && \
    ln -sf /opt/helix/runtime $HOME/.config/helix/runtime && \
COPY config.toml /root/.config/helix/

RUN apk update && apk add build-base && apk add fish npm curl
RUN npm i intelephense -g

#COPY --from=helixbuild /opt/cargo/bin/hx /bin/hx
#COPY --from=helixbuild /opt/helix/runtime /bin/runtime
#RUN  hx -g fetch && hx -g build
#COPY --from=helixbuild /root/.config/helix/config.toml $HOME/.config/helix/config.toml

#RUN mkdir -p /workspace && chown -R user:user /workspace && chown -R user:user /home/user/ && chown -R user:user /bin/runtime &&\
#rm -rf /home/user/.config/helix/runtime && ln -s /bin/runtime /home/user/.config/helix/
USER ${USER}

#COPY --from=rustanalyzerbuild /opt/helix/runtime $HOME/.config/helix/runtime
#COPY --from=rustanalyzerbuild /root/.config/helix/config.toml $HOME/.config/helix/config.toml#WORKDIR /home/${USER}
ENV COLORTERM=truecolor
ENV TERM xterm-256color
WORKDIR /workspace
CMD [ "/usr/bin/fish" ]⏎
