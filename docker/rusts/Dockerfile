# Temporary builder image for rust toolchain
FROM debian:stable-slim AS rustbuild
RUN apt update && apt install -y git fish curl build-essential 
ENV RUSTUP_HOME=/opt/rustup
ENV CARGO_HOME=/opt/cargo
ENV PATH="${PATH}:${CARGO_HOME}/bin"
env CARGO_NET_GIT_FETCH_WITH_CLI=true
RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y && \
    rustup component add rust-src
RUN rustup toolchain install nightly -c rust-src

# Build helix editor
FROM rustbuild AS helixbuild
ENV COLORTERM=truecolor
ENV TERM xterm-256color
RUN git clone https://github.com/helix-editor/helix /opt/helix && \
    cd /opt/helix && \
    rustup override set stable && \
    cargo install --locked --path helix-term && cargo clean && \
    mkdir -p /root/.config/helix && \
    ln -sf /opt/helix/runtime /root/.config/helix/runtime
COPY config.toml /root/.config/helix/
# Build rust-analyzer binary
FROM helixbuild AS rustanalyzerbuild
RUN git clone https://github.com/rust-lang/rust-analyzer.git /opt/rust-analyzer && \
    cd /opt/rust-analyzer && \
    rustup override set nightly && \
    rustup override set nightly &&\
    cargo xtask install --server
 

FROM rustanalyzerbuild AS lib

FROM rustanalyzerbuild AS interactive
ARG UID=10000
ARG GID=10000
ENV HOME=/home/user
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y  libssl-dev \
  build-essential git libcurl4-openssl-dev pkg-config fish libdbus-1-dev pkg-config \
  libnftnl-dev libprotobuf-dev protobuf-compiler libmnl-dev

RUN  addgroup --gid ${GID} user && \
    adduser --uid ${UID} --gid ${GID} --home /home/user --gecos "" --disabled-password user && \
    mkdir -p /home/user/.config/fish && chown -R user:user /home/user && \
    chown -R user:user /opt/ && chown -R user:user /usr/local && \
    mkdir -p /workspace/target && chown -R user:user /workspace && \
    mkdir -p /home/user/.config && cp -Rv /root/.config/helix /home/user/.config/helix && \
    chown -R user:user /home/user/.config/helix

USER user
RUN cargo install cargo-edit bacon
ENV COLORTERM=truecolor
ENV TERM xterm-256color
WORKDIR /workspace
CMD [ "/usr/bin/fish" ]
