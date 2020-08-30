#!/bin/sh
set -o errexit -o nounset

echo "Updating node dependencies."
npm install -g tern
