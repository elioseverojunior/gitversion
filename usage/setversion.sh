#!/usr/bin/env bash

set -x

SOLUTIONDIR="./"

echo "Current Build Number: ${JENKINS_BUILD_NUMBER}"

if [[ ! -z "${BRANCH_NAME}" ]];
then
  gitversion ${SOLUTIONDIR} /b ${BRANCH_NAME} /updateassemblyinfo > gitversion.json
else
  gitversion ${SOLUTIONDIR} /updateassemblyinfo > gitversion.json
fi

cat gitversion.json

VERSION=$(cat gitversion.json | jq -r .FullSemVer)
if [[ ! -z "${VERSION}" ]]
then
  sed -Ei "s/(version:.?)(.*)/\1$VERSION/g" build.yaml
fi

echo "${VERSION}"