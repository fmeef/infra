FROM registry.ballmerlabs.net/rusts:latest AS rustanalyzerbuild

FROM debian:stable-slim AS pythonbuild
ARG USER=user
ARG UID=10001
ARG VERSION=3.11
RUN apt update && apt install -y git curl build-essential libbz2-dev liblzma-dev whois \
 libreadline-dev libssl-dev zlib1g-dev libffi-dev libsqlite3-dev fish lzma-dev

RUN apt install -y libglib2.0-dev libdbus-1-dev python3-dev

COPY --from=rustanalyzerbuild /opt/cargo/bin/hx /bin/hx
RUN adduser --disabled-password --home "/home/${USER}" --uid ${UID} ${USER}
USER ${USER}
ENV HOME=/home/${USER}
WORKDIR /home/${USER}
RUN git clone https://github.com/yyuu/pyenv.git /$HOME/.pyenv
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN pyenv install ${VERSION} && mkdir -p $HOME/.config/fish && \
mkdir -p $HOME/.local/share/virtualenvs && \
mkdir -p $HOME/.config/helix && \
 echo "pyenv init - fish | source" >> $HOME/.config/fish/config.fish &&\
 echo pyenv init >> $HOME/.bash_profile && \
fish -c "set -Ux PYENV_ROOT $HOME/.pyenv; set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths"
RUN pyenv rehash && pyenv local ${VERSION} && pip install pipenv virtualenv python-lsp-server
COPY --from=rustanalyzerbuild /opt/helix/runtime $HOME/.config/helix/runtime
COPY --from=rustanalyzerbuild /root/.config/helix/config.toml $HOME/.config/helix/config.toml
ENV COLORTERM=truecolor
ENV TERM xterm-256color
WORKDIR /workspace
RUN pyenv global ${VERSION}
CMD [ "fish" ]