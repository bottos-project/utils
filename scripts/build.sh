#!/bin/bash

set -e
set -x

REGISTRY=microhq

# Used to rebuild all the things

find * -type d -maxdepth 1 -print | while read dir; do
	if [ ! -f $dir/Dockerfile ]; then
		continue
	fi

	pushd $dir >/dev/null

	# build static binary
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-w' -o $dir ./main.go

	# build docker image
	docker build -t $REGISTRY/$dir .

	# push docker image
	docker push $REGISTRY/$dir

	popd >/dev/null
done
