#!/bin/sh
for i in CC65 VBCC LLVM; do make release TOOLCHAIN=$i; done
make clean
