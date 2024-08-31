#!/usr/bin/env bash
set -x
USER=ctxswitch
FORMULA=$1
REPO=$2
# RELEASE_URL=$2
RELEASE_URL="https://api.github.com/repos/${USER}/${REPO}/releases/latest"

if [ -z "$FORMULA" ] || [ -z "$RELEASE_URL" ]; then
  echo "Usage: bump-to-latest.sh <formula> <release-url>"
  exit 1
fi

# Get the latest version from the release URL
LATEST_VERSION=$(curl -sSL $RELEASE_URL | jq -r '.name')
SOURCE_URL="https://github.com/${USER}/${REPO}/archive/refs/tags/${LATEST_VERSION}.tar.gz"
TMP_FILE=/tmp/${FORMULA}.latest.tar.gz
# Download the latest version to check the SHA256
curl -sSL $SOURCE_URL -o ${TMP_FILE}
# Calculate the SHA256
SHA256=$(shasum -a 256 $TMP_FILE | awk '{print $1}')

# Update the formula with the latest version and sha256
sed -i '' \
  -e "s/\(url \".*\/tags\/\).*.tar.gz\(\".*\)/\1${LATEST_VERSION}\2/" \
  -e "s/\(sha256 \"\).*\(\".*\)/\1${SHA256}\2/" \
  Formula/${FORMULA}.rb
