# srb2kart-docker-debian

Compile [srb2kart](https://github.com/STJr/Kart-Public) inside a Docker container.

This project was born after having problems with _Linux Installation Instructions_. If you're having problems too, try this method.

## Dependencies

* [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-debian-10)
* `git`
* `nasm`
* `libpng-dev`
* `zlib1g-dev`
* `libsdl2-dev`
* `libsdl2-mixer-dev`
* `libgme-dev`
* `libopenmpt-dev`
* `libcurl4-gnutls-dev`

```console
user@system:~$ sudo apt-get install -y git nasm libpng-dev zlib1g-dev libsdl2-dev libsdl2-mixer-dev libgme-dev libopenmpt-dev libcurl4-gnutls-dev
```

## Steps to follow

Run these commands in a terminal:

```console
user@system:~$ git clone https://github.com/AquoDev/srb2kart-docker-debian.git
user@system:~$ cd srb2kart-docker-debian
user@system:srb2kart-docker-debian$ sh build.sh
```

## Expected result

Everything will be inside a folder called `build`, which has the following structure:

```
build
├── bonuschars.kart
├── chars.kart
├── gfx.kart
├── maps.kart
├── music.kart
├── patch.kart
├── sounds.kart
├── srb2kart <== Binary
├── srb2.srb
└── textures.kart

0 directories, 10 files
```
