#!/run/current-system/sw/bin/env zsh
set -e
sudo -- sh -c "vim /etc/nixos/"
echo "Commit message?"
msg=$(read -e)
sudo -- sh -c "nixos-rebuild switch"
(cd /etc/nixos/ && git add . && git commit -m "$msg" && git push)
echo "Commited $msg"
