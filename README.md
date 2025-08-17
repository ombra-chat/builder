# Base Docker image for building ombra-chat

This repository provides a Docker image that can be used to build [ombra-chat](https://github.com/ombra-chat/ombra-chat).

In particular, it provides:

* the tdlib library
* node
* rust
* [tauri dependencies](https://v2.tauri.app/start/prerequisites/)

The Dockerfile builds tlib using the instruction from https://tdlib.github.io/td/build.html?language=C
