from registry.ballmerlabs.net/rusts:latest
ARG UID=10000
ARG GID=10000
ENV HOME=/home/user
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update  --allow-releaseinfo-change  && \
apt install -y  libssl-dev curl \
  build-essential git python3-dev python3-pip wget sudo clangd socat openocd python3-serial

COPY FBT-AARCH64 /opt/FBT-AARCH64
RUN echo y | bash /opt/FBT-AARCH64/setup.sh

RUN  addgroup --gid ${GID} user && \
    adduser --uid ${UID} --gid ${GID} --home /home/user --gecos "" --disabled-password user && \
    adduser user sudo && \
    mkdir -p /home/user/.config/fish && chown -R user:user /home/user && \
    chown -R user:user /opt/ && chown -R user:user /usr/local && \
    mkdir -p /workspace/target && chown -R user:user /workspace && \
    mkdir -p /home/user/.config && cp -Rv /root/.config/helix /home/user/.config/helix && \
    chown -R user:user /home/user/.config/helix &&\
   echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt  --allow-releaseinfo-change update && \
apt install -y git curl build-essential libbz2-dev liblzma-dev \
 libreadline-dev libssl-dev zlib1g-dev libffi-dev libsqlite3-dev fish lzma-dev ripgrep protobuf-compiler

RUN apt install -y libglib2.0-dev libdbus-1-dev python3-dev
COPY entrypoint.sh /entrypoint.sh
USER user


WORKDIR /home/${USER}
RUN git clone https://github.com/yyuu/pyenv.git /$HOME/.pyenv
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN pyenv install 3.11 && mkdir -p $HOME/.config/fish && \
 echo "pyenv init - fish | source; pyenv shell 3.11" >> $HOME/.config/fish/config.fish &&\
 echo 'eval "$(pyenv init -)"' >> $HOME/.bash_profile && \
 echo 'eval "$(pyenv init -)"' >> $HOME/.profile && \
fish -c "set -Ux PYENV_ROOT $HOME/.pyenv; set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths" && \
bash -c "source $HOME/.bash_profile && pyenv shell 3.11 && pip install --upgrade ufbt colorlog \
  google-api-python-client protobuf==3.20.0 pillow heatshrink2 pyserial ansi scons" 
ENV COLORTERM=truecolor
ENV TERM xterm-256color
RUN git config --global --add safe.directory /workspace
RUN pyenv global 3.11
WORKDIR /workspace
CMD bash /entrypoint.sh


