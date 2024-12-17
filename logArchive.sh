#!/bin/bash

if [ -z "$1" ]; then
	echo "Use: logArchive <log-dir> "
	exit 1
fi

LOGS_D="$1"

if ! [ -d "$LOGS_D" ]; then
	echo "Dir <$LOGS_D> not found"
	exit 1
fi


if ! [ -r "$LOGS_D" ]; then
	echo "<$LOGS_D> file is not readable"
	exit 1
fi

handle_error()
{
	echo "error"
	exit 1
}

DATE=$(date +'%e.%m.%Y')
NAME=$(basename "$LOGS_D")
TIME=$(date +'%H.%M.%S')

DIR_NAME="$NAME"_archive_"$DATE"_"$TIME".tar.gz

trap 'handle_error' ERR

tar -czvf "$DIR_NAME" "$LOGS_D"

echo "$DIR_NAME was created"
