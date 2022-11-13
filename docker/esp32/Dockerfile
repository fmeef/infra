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
    cargo install --path helix-term

# Build rust-analyzer binary
FROM helixbuild AS rustanalyzerbuild
RUN git clone https://github.com/rust-lang/rust-analyzer.git /opt/rust-analyzer && \
    cd /opt/rust-analyzer && \
    cargo xtask install --server
        
# Build espressif image with rust tooling
FROM espressif/idf:v4.4.3 AS run
RUN apt update && apt install -y llvm-dev clang clang-tools build-essential git fish clangd 
ENV RUSTUP_HOME=/opt/rustup
ENV CARGO_HOME=/opt/cargo
ENV PATH="${PATH}:${CARGO_HOME}/bin"
ENV COLORTERM=truecolor
ENV TERM xterm-256color
COPY --from=rustanalyzerbuild /opt/cargo /opt/cargo
COPY --from=rustanalyzerbuild /opt/rustup /opt/rustup
RUN mkdir -p /root/.config/helix
COPY --from=rustanalyzerbuild /opt/helix/runtime /root/.config/helix/runtime
