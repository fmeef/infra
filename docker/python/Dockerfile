FROM registry.ballmerlabs.net/rusts:latest AS rustanalyzerbuild

FROM debian:stable-slim AS pythonbuild
RUN apt update && apt install -y git curl build-essential libbz2-dev \
 libreadline-dev libssl-dev zlib1g-dev 
RUN git clone https://github.com/yyuu/pyenv.git /root/.pyenv
ENV HOME  /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN pyenv install 3.10.4
