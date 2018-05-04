# Docker image for installing dependencies on Linux and running tests.
# Build with:
# docker build --tag=zbarcam .
# Run with:
# docker run zbarcam /bin/sh -c '. venv/bin/activate && make test'
# Or for interactive shell:
# docker run -it --rm zbarcam
# TODO:
#	- delete archives to keep small the container small
#	- setup caching (for apt, and pip)
FROM ubuntu:18.04

# configure locale
RUN apt update -qq > /dev/null && apt install --yes --no-install-recommends \
    locales && \
    locale-gen en_US.UTF-8
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

# install system dependencies
RUN apt update -qq > /dev/null && apt install --yes --no-install-recommends \
    make lsb-release sudo

WORKDIR /app
COPY . /app
RUN make
