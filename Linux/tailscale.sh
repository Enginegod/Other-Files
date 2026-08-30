curl -fsSL https://tailscale.com/install.sh | sh

sudo tailscale up

sudo systemctl status ssh # или для некоторых систем: sudo systemctl status sshd
sudo systemctl enable --now ssh