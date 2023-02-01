from registry.ballmerlabs.net/rusts:latest as rustanalyzerbuild       
# Build espressif image with rust tooling
FROM espressif/idf:v4.4.3 AS run
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y llvm-dev clang clang-tools build-essential \
     git fish clangd pkg-config libudev-dev fontconfig libfontconfig1-dev
ENV RUSTUP_HOME=/opt/rustup
ENV CARGO_HOME=/opt/cargo
ENV PATH="${PATH}:${CARGO_HOME}/bin"
ENV COLORTERM=truecolor
ENV TERM xterm-256color
COPY --from=rustanalyzerbuild /opt/cargo /opt/cargo
COPY --from=rustanalyzerbuild /opt/rustup /opt/rustup
RUN mkdir -p /root/.config/helix
COPY --from=rustanalyzerbuild /opt/helix/runtime /root/.config/helix/runtime
RUN cargo install cargo-generate ldproxy espflash espmonitor cargo-espflash
