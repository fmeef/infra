FROM registry.ballmerlabs.net/rusts:latest AS rustanalyzerbuild

FROM debian:stable-slim AS pythonbuild
ARG USER=user
ARG UID=10001
ARG VERSION=3.10.4
RUN apt update && apt install -y git curl build-essential libbz2-dev liblzma-dev \
 libreadline-dev libssl-dev zlib1g-dev libffi-dev libsqlite3-dev fish lzma-dev ruby-dev ruby \
libglib2.0-dev libdbus-1-dev python3-dev automake autoconf libtool 
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&\
apt-get install -y nodejs
RUN npm install -g typescript-language-server typescript
COPY --from=rustanalyzerbuild /opt/cargo/bin/hx /bin/hx
RUN adduser --disabled-password --home "/home/${USER}" --uid ${UID} ${USER}
RUN mkdir -p /workspace && chown -R user:user /workspace
VOLUME /workspace
USER ${USER}
ENV HOME=/home/${USER}
RUN curl -sSL https://get.rvm.io | bash
RUN curl -L --create-dirs -o ~/.config/fish/functions/rvm.fish https://raw.github.com/lunks/fish-nuggets/master/functions/rvm.fish
#RUN gem install --user bundler jekyll
RUN $HOME/.rvm/bin/rvm autolibs disable && $HOME/.rvm/bin/rvm requirements 
RUN $HOME/.rvm/bin/rvm install ruby
RUN bash -l -c ". $HOME/.bash_profile && . ~/.bashrc && rvm use ruby && gem install bundler jekyll"
RUN echo rvm use ruby >> $HOME/.profile && echo rvm use ruby >> $HOME/.config/fish/config.fish
WORKDIR /home/${USER}
COPY --from=rustanalyzerbuild /opt/helix/runtime $HOME/.config/helix/runtime
COPY --from=rustanalyzerbuild /root/.config/helix/config.toml $HOME/.config/helix/config.toml
ENV COLORTERM=truecolor
ENV TERM xterm-256color
WORKDIR /workspace
