FROM debian:12 AS builder-stage

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y make git zlib1g-dev libssl-dev gperf php-cli cmake g++ 

RUN git clone https://github.com/tdlib/td.git

WORKDIR /td

# 1.8.50
RUN git checkout e133ac6d049f5d56821cec6a3e5501cb20965c66

RUN mkdir build

WORKDIR /td/build

RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../tdlib ..
RUN cmake --build . --target install

# copying the files to the target directory
FROM scratch
COPY --from=builder-stage /td/tdlib/lib/libtdjson.so.* /
