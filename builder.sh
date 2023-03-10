#!/bin/sh

BOOTSTRAP_VERSION="vxworks_0.3"

# utility script used in process of porting golang to vxworks

# build the bootstrap compiler
# this version of go is built using the stock go compiler and recognizes
# vxworks as a platform
build_bootstrap() {
    export GCFLAGS="all=-N -l" # disable optimizations
    export GOROOT_BOOTSTRAP="" # which go compiler to use to build
    export GOROOT="$(pwd)"
    export GOTOOLSDIR="./pkg/" # where to install tools
    export GOOS="linux"
    export GOARCH="amd64"

    INSTALL_DIR="$HOME/Temp/go_versions/$BOOTSTRAP_VERSION"
    mkdir -p $INSTALL_DIR

    cd src
    ./make.bash
    cd ..
    cp -r bin "$INSTALL_DIR"
    cp -r pkg "$INSTALL_DIR"
    cp -r src "$INSTALL_DIR"
}

build_next() {
    export CGO_ENABLED="1"
    export GCFLAGS="all=-N -l" # disable optimizations
    export GOROOT_BOOTSTRAP="$HOME/Temp/go_versions/$BOOTSTRAP_VERSION" # which go compiler to use to build
    export GOROOT="$(pwd)"
    export GOOS="linux"
    export GOARCH="amd64"

    cd src
    $GOROOT/bin/go install cmd/go
    $GOROOT/bin/go install cmd/compile
    $GOROOT/bin/go install cmd/link
    $GOROOT/bin/go install cmd/cgo
    # ./make.bash
    # ./all.bash
}

testing() {
    export GOOS=vxworks
    export GOARCH=amd64
    export GCFLAGS="all=-N -l"
    export CGO_ENABLED=1
    export GOROOT="$(pwd)"
    ~/Installs/goroot/bin/go test -tags 'unix' -run TestPutchar -v -count=1 runtime
}

# build next with system toolchain
build_next_system() {
    export GCFLAGS="all=-N -l" # disable optimizations
    export GOROOT_BOOTSTRAP="" # which go compiler to use to build
    export GOROOT="$(pwd)"
    export GOOS="linux"
    export GOARCH="amd64"

    cd src
    # ./make.bash
    $GOROOT/bin/go install cmd/compile
}

build_vxworks() {
    export CGO_ENABLED="1"
    export GCFLAGS="all=-N -l -tags unix" # disable optimizations
    export GOROOT_BOOTSTRAP="$HOME/Temp/go_versions/$BOOTSTRAP_VERSION" # which go compiler to use to build
    export GOROOT="$(pwd)"
    export GOOS="vxworks"
    export GOARCH="amd64"

    cd src
    # $GOROOT/bin/go install cmd/compile
    echo '[BUILD] Building cmd/link...'
    $GOROOT/bin/go install -tags unix cmd/link
    echo '[BUILD] Building cmd/compile...'
    $GOROOT/bin/go install -tags unix cmd/compile
    # ./make.bash
}


case $1 in
    bootstrap) build_bootstrap;;
    next) build_next;;
    next_system) build_next_system;;
    vxworks) build_vxworks;;
    test) testing;;
    *) echo "invalid operation";;
esac
