#!/usr/bin/env bash

set -euxo pipefail

PS4='+${BASH_SOURCE[0]}:$LINENO: '
if [[ -t 1 ]] && type -t tput >/dev/null; then
  if (( "$(tput colors)" == 256 )); then
    PS4='$(tput setaf 10)'$PS4'$(tput sgr0)'
  else
    PS4='$(tput setaf 2)'$PS4'$(tput sgr0)'
  fi
fi

# Install prerequisite packages.
sudo apt-get -y update
sudo apt-get -y dist-upgrade
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*
sudo chown vscode:vscode /workspaces

# Install uv.
curl -LsSf https://astral.sh/uv/install.sh | sh
. "$HOME/.cargo/env"
uv python install --no-progress

pushd /workspaces/majsoul-liqi-json
rm -rf .venv
uv venv
uv pip install -U \
  jsonschema \
  types-jsonschema
popd
