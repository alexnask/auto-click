#!/bin/sh

CC=clang
ROCK=rock

echo "Outputing to bin/auto-click"
echo "Make sure ROCK_DIST is set"


mkdir -p bin
${CC} -c source/utils.c -o source/utils.o
${ROCK}
cd snowflake
make
cd ..
cp snowflake/main bin/auto-click
rm -rf snowflake source/utils.o


echo "Done!"
