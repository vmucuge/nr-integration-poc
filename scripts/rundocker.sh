#!/bin/bash
NAME=$1
VERSION=$2

build () {
  docker build -t $NAME:$VERSION .
}

run () {
  docker run --name $NAME-$VERSION --hostname $NAME-$VERSION $NAME:$VERSION
}

destroy () {
  docker rm -f $NAME-$VERSION
}

build
run
