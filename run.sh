#!/bin/bash

function checkFor() {
  command -v "$1" >/dev/null 2>&1 || {
    echo >&2 "$1 is not installed.  Aborting."
    exit 1
  }
}

function buildProject() {
  docker container stop "$(docker ps -a -q)"
  checkFor mvn
  mvn clean install
}

function generateSSL() {
  pushd proxy || exit
  ./create_ca.sh
  ./issue_cert.sh
  popd || exit
}


# clean up
/bin/bash clear.sh


# generateSSL

# start services
# mvn clean install
docker-compose -f docker-compose.yml up -d --build

# update kong configuration
sleep 2s
# deck ping
# deck sync

docker-compose ps