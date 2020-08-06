#!/usr/bin/env bash

set -ev

docker-compose pull
docker-compose build --pull testrunner

docker-compose up -d node-chrome node-firefox hub web

# wait for the selenium grid browser nodes to register with the selenium grid hub
sleep 10

docker-compose run --rm testrunner && echo $?

exit_code=$?
echo "testrunner container exited with: ${exit_code}"

if [[ "${exit_code}" == "0" ]]; then
  echo ":: It's working!"
else
  echo ":: Test Failed :("
  exit_code=1
fi

exit ${exit_code}
