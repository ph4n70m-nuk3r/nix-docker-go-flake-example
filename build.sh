## Print informational message. ##
echo ">>>>>>>>>> STARTING [$(date -Is)] <<<<<<<<<<"
## Exit on regular command failures. ##
set -e
## Fail script if a command which feeds into a pipe fails. ##
set -o pipefail
## Treat unset variables as failures if expanded. ##
set -u
## Enable basic command traces. ##
set -x
## Use PAT for Github to ease rate limiting. ##
. ./export-gh-pat.sh
export NIX_CONFIG="access-tokens = github.com=${GH_PAT}"
## Run Go app built from flake. ##
nix \
  --extra-experimental-features 'nix-command' \
  --extra-experimental-features 'flakes' \
  build \
  .#docker
## Print informational message. ##
echo ">>>>>>>>>> FINISHED [$(date -Is)] <<<<<<<<<<"
## Exit success. ##
exit 0
