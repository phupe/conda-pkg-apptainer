#!/bin/bash
set -xeuf

cp ${PREFIX}/bin/unsquashfs ${PREFIX}/bin/unsquashfs4apptainer
cp ${PREFIX}/bin/mksquashfs ${PREFIX}/bin/mksquashfs4apptainer

# See https://github.com/apptainer/apptainer/issues/519
# this patch avoids having relative PATh to the shared libraries
# needed by unsquasfs
patchelf --set-rpath ${PREFIX}/lib ${PREFIX}/bin/unsquashfs4apptainer
patchelf --set-rpath ${PREFIX}/lib ${PREFIX}/bin/mksquashfs4apptainer


echo "mksquashfs path = ${PREFIX}/bin/mksquashfs4apptainer" >> ${PREFIX}/etc/apptainer/apptainer.conf
echo "unsquashfs path = ${PREFIX}/bin/unsquashfs4apptainer" >> ${PREFIX}/etc/apptainer/apptainer.conf

