#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux

# Install Ruby and GTK3 bindings for my-little-eye
dnf5 install -y rubygem-gtk3

#### Install my-little-eye screen monitoring service

# Install the script to immutable /usr tree
cp /ctx/my-little-eye /usr/libexec/my-little-eye
chmod +x /usr/libexec/my-little-eye

# Install the user service file
mkdir -p /etc/systemd/user
cp /ctx/my-little-eye.service /etc/systemd/user/my-little-eye.service

# Enable the service globally for all users
systemctl --global enable my-little-eye.service

#### Example for enabling a System Unit File

systemctl enable podman.socket
