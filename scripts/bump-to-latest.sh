#!/usr/bin/env bash
set -ex
USER=ctxswitch
FORMULA=$1
REPO=$2
# RELEASE_URL=$2
RELEASE_URL="https://api.github.com/repos/${USER}/${REPO}/releases/latest"

if [[ -z "${FORMULA}" ]] || [[ -z "${RELEASE_URL}" ]]
then
  echo "Usage: bump-to-latest.sh <formula> <release-url>"
  exit 1
fi

# Get the latest version from the release URL
RELEASE_DATA=$(curl -sSL "${RELEASE_URL}")
LATEST_VERSION=$(jq -r '.name' <<<"${RELEASE_DATA}")
SOURCE_URL="https://github.com/${USER}/${REPO}/archive/refs/tags/${LATEST_VERSION}.tar.gz"
TMP_FILE=/tmp/${FORMULA}.latest.tar.gz
# Download the latest version to check the SHA256
curl -sSL "${SOURCE_URL}" -o "${TMP_FILE}"
# Calculate the SHA256
SHASUM_OUT=$(shasum -a 256 "${TMP_FILE}")
SHA256=$(awk '{print $1}' <<<"${SHASUM_OUT}")

# Update the formula with the latest version and sha256
sed -i '' \
  -e "s/\(url \".*\/tags\/\).*.tar.gz\(\".*\)/\1${LATEST_VERSION}\2/" \
  -e "s/\(sha256 \"\).*\(\".*\)/\1${SHA256}\2/" \
  Formula/"${FORMULA}".rb
