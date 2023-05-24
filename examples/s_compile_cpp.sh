#!/bin/bash

set -ex

OPTS="-mavx2 -O2"

SANITIZER_OPTS="-O1 -g -fsanitize=address -fno-omit-frame-pointer -fsanitize=undefined"

[ -n "$1" ] || [ "$1" == "asan" ] && OPTS="$OPTS $SANITIZER_OPTS"

for cpp in $(find . -type f -name "*.cpp"); do
    echo "compiling ${cpp}..."
    c++ -Wall "${cpp}" -o $(basename "${cpp}" .cpp) $OPTS -DANNOYLIB_MULTITHREADED_BUILD -std=c++14 -pthread
    echo "Done"
done