#!/bin/bash
set -xeuf

# Workaround for travis permissions errors which end up creating very verbose log output
if [[ $(uname -m) == "ppc64le" ]]; then
    export GOPATH=${TMPDIR:-/tmp}/gopath
    mkdir -p "${GOPATH}"
fi

echo $CPPFLAGS

pushd src/github.com/apptainer/${PKG_NAME}

# configure
./mconfig \
  -P release-stripped \
  --without-suid \
  -p "${PREFIX}" \
  -c "${CC}" \
  -x "${CXX}"

go env

# The "starter" binary inherits the stack from "singularity" meaning FORTIFY_SOURCE cannot be used
#CGO_CPPFLAGS=$(echo "${CGO_CPPFLAGS}" | sed -E 's@FORTIFY_SOURCE=[0-9]@FORTIFY_SOURCE=0@g')
#export CGO_CPPFLAGS

# build

pushd builddir
export LD_LIBRARY_PATH=${PREFIX}/lib
make

# install
make install

# Make Empty session dir
mkdir -p $PREFIX/var/${PKG_NAME}/mnt/session
touch $PREFIX/var/${PKG_NAME}/mnt/session/.mkdir
