#!/bin/bash
set -xeuf

# See https://github.com/apptainer/apptainer/issues/519
# this patch avoids having relative PATh to the shared libraries
# needed by unsquasfs
patchelf --set-rpath ${PREFIX}/lib ${PREFIX}/bin/unsquashfs
patchelf --set-rpath ${PREFIX}/lib ${PREFIX}/bin/mksquashfs
