#!/bin/sh

# utility script used in process of porting golang to vxworks

# build the bootstrap compiler
# this version of go is built using the stock go compiler and recognizes
# vxworks as a platform
build_bootstrap() {
    export GCFLAGS="all=-N -l" # disable optimizations
    export GOROOT_BOOTSTRAP="" # which go compiler to use to build
    export GOROOT="$(pwd)"
    export GOTOOLSDIR="./pkg/" # where to install tools

    INSTALL_DIR="$HOME/Temp/go_versions/vxworks"

    cd src
    ./make.bash
    cd ..
    cp -r bin "$INSTALL_DIR"
    cp -r pkg "$INSTALL_DIR"
    cp -r src "$INSTALL_DIR"
}

build_next() {
    export GCFLAGS="" # disable optimizations
    export GOROOT_BOOTSTRAP="$HOME/Temp/go_versions/vxworks" # which go compiler to use to build
    export GOROOT="$(pwd)"
    export GOOS="linux"
    export GOARCH="amd64"

    cd src
    # $GOROOT/bin/go install cmd/compile
    ./make.bash
}

# build next with system toolchain
build_next_system() {
    export GCFLAGS="" # disable optimizations
    export GOROOT_BOOTSTRAP="" # which go compiler to use to build
    export GOROOT="$(pwd)"
    export GOOS="linux"
    export GOARCH="amd64"

    cd src
    ./make.bash
}


case $1 in
    bootstrap) build_bootstrap;;
    next) build_next;;
    next_system) build_next_system;;
    *) echo "invalid operation";;
esac
