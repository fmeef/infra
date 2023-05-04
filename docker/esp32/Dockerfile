ARG IDF_VERSION=release-v5.1   
FROM registry.ballmerlabs.net/rusts:latest as rustanalyzerbuild 
   
# Build espressif image with rust tooling
FROM  espressif/idf:$IDF_VERSION
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y  build-essential cmake python3 python3-pip python3-virtualenv \
     git fish clang pkg-config libudev-dev fontconfig libfontconfig1-dev libssl-dev
ENV RUSTUP_HOME=/opt/rustup
ENV CARGO_HOME=/opt/cargo
ENV PATH="${PATH}:${CARGO_HOME}/bin"
ENV COLORTERM=truecolor
ENV TERM xterm-256color
#ENV IDF_TOOLCHAIN=clang 
COPY --from=rustanalyzerbuild /opt/cargo /opt/cargo
COPY --from=rustanalyzerbuild /opt/rustup /opt/rustup
COPY --from=rustanalyzerbuild /root/.config/helix /root/.config/helix
COPY --from=rustanalyzerbuild /opt/helix/runtime /root/.config/helix/runtime
RUN cargo install cargo-generate ldproxy espflash espmonitor cargo-espflash cargo-edit
#RUN mkdir -p /opt/clang && cd /opt/clang && git clone --depth 1 https://github.com/espressif/llvm-project.git && \
#cd llvm-project && mkdir -p build && cd build && \
#cmake ../llvm -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_INSTALL_PREFIX=/opt/clang -DLLVM_TARGETS_TO_BUILD="RISCV;X86" -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="Xtensa" -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;libc;libcxx;libcxxabi" -G "Ninja" 
#WORKDIR /opt/clang/llvm-project/build
#RUN cmake --build .
#RUN ninja install
