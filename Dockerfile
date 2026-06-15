# Keeping old version to ensure glibc compatibilty
FROM debian:12

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y make git zlib1g-dev libssl-dev gperf php-cli cmake g++ wget curl pkg-config libwebkit2gtk-4.1-dev build-essential file libxdo-dev libayatana-appindicator3-dev librsvg2-dev xdg-utils

WORKDIR /

# Build tdlib
RUN git clone https://github.com/tdlib/td.git

WORKDIR /td

# 1.8.65
RUN git checkout a8f21f5230172634becc1739050ef23ecd6ea291

RUN mkdir build

WORKDIR /td/build

RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ..
RUN cmake --build . --target install

# Verify that tdjson can be found by pkg-config
RUN PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1 pkg-config --libs --cflags tdjson 'tdjson >= 1.8.65'

RUN cp /usr/local/lib/libtd* /usr/lib

WORKDIR /opt

# Install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install node
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN bash -c "source $NVM_DIR/nvm.sh && nvm install 24"

WORKDIR /

# entrypoint to set environment variables
ENTRYPOINT ["bash", "-c", "source $HOME/.nvm/nvm.sh && source $HOME/.cargo/env && exec \"$@\"", "--"]

CMD ["/bin/bash"]
