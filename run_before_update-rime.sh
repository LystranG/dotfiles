#!/bin/sh

set -eu

repo="$HOME/Library/Rime"
url="https://github.com/Mintimate/oh-my-rime.git"

if [ ! -d "$repo/.git" ]; then
  /usr/bin/git clone --origin upstream "$url" "$repo"
  exit 0
fi

if ! /usr/bin/git -C "$repo" remote get-url upstream >/dev/null 2>&1; then
  /usr/bin/git -C "$repo" remote add upstream "$url"
fi

actual_url=$(/usr/bin/git -C "$repo" remote get-url upstream)
if [ "$actual_url" != "$url" ]; then
  echo "Rime upstream mismatch: expected $url, got $actual_url" >&2
  exit 1
fi

/usr/bin/git -C "$repo" pull --ff-only upstream main
