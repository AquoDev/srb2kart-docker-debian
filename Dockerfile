##################
# Build srb2kart #
##################
FROM debian:10 as builder

# Needed to checkout that release tag
ARG VERSION

# Install essential tools and libraries
RUN apt-get update && apt-get install apt-file -y && apt-file update
RUN apt-get install -y build-essential git nasm libpng-dev zlib1g-dev libsdl2-dev libsdl2-mixer-dev libgme-dev libopenmpt-dev libcurl4-gnutls-dev

# Clone the repo and checkout v${VERSION} tag (example: v1.2)
RUN git clone https://github.com/STJr/Kart-Public.git /srb2kart
WORKDIR /srb2kart
RUN git checkout -q v${VERSION}

# Time to compile (it can take a while)
ENV LIBGME_CFLAGS=
ENV LIBGME_LDFLAGS=-lgme
RUN make -C src/ LINUX64=1


##################
# Extract assets #
##################
FROM debian:10 as assets

# Needed to download assets from that version
ARG VERSION
ARG NO_DOT_VERSION

# Install tools to download and extract assets
RUN apt-get update && apt-get install apt-file -y && apt-file update
RUN apt-get install -y wget p7zip-full

# Download assets and extract them
RUN wget https://github.com/STJr/Kart-Public/releases/download/v${VERSION}/srb2kart-v${NO_DOT_VERSION}-Installer.exe
RUN mv srb2kart-v${NO_DOT_VERSION}-Installer.exe assets.exe
RUN 7z x assets.exe -o/srb2kart


####################################
# Copy everything to a clean image #
####################################
FROM debian:10 as result

WORKDIR /build

COPY --from=builder /srb2kart/bin/Linux64/Release/lsdl2srb2kart srb2kart
COPY --from=assets /srb2kart/*.kart ./
COPY --from=assets /srb2kart/srb2.srb .

ENTRYPOINT [ "sleep", "30" ]
