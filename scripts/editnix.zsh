#!/run/current-system/sw/bin/env zsh
set -e
echo "Commit message?"
msg=$(read -e)
sudo -- sh -c "vim /etc/nixos/ && nixos-rebuild switch"
(cd /etc/nixos/ && git add . && git commit -m "$msg - Revision $(date)" && git push)
echo "Commited $msg"
