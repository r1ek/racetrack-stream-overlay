#!/bin/sh
# Stamp a build id into index.html and version.json, commit and push (GitHub Pages serves main).
set -e
cd "$(dirname "$0")"
b=$(date +%Y%m%d%H%M%S)
sed -i '' "s/var BUILD = '[^']*';/var BUILD = '$b';/" index.html
printf '{"build":"%s"}\n' "$b" > version.json
git add -A
git commit -q -m "${1:-Publish} (build $b)"
git -c credential.helper= -c credential.helper='!gh auth git-credential' push -q origin main
echo "published build $b"
