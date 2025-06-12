# libtdjson.so

This repository provides a pre-built version of libtdjson.so, to simplify the development of Linux Telegram clients.

## Installation

Download the files from the [latest release](https://github.com/ombra-chat/libtdjson-linux/releases).

Install the libtdjson library:

```sh
sudo cp libtdjson.so.* /usr/local/lib/libtdjson.so
```

## How it works

The Dockerfile uses the instruction from https://tdlib.github.io/td/build.html?language=C

## License

This repository provides a repackaging of [tdlib](https://github.com/tdlib/td), that is released with Boost Software License - copyright Aliaksei Levin (levlam@telegram.org), Arseny Smirnov (arseny30@gmail.com) 2014-2025.
