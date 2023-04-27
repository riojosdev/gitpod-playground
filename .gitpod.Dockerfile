FROM ubuntu:latest



USER root
# RUN chmod 777 /home
# USER user

# Securing the server: Firewall basics (optional, recommended)
RUN apt update \
    && apt-get install ufw -y \
    && ufw default deny incoming \
    && ufw default allow outgoing \
    && ufw allow 22/tcp \
    && ufw allow 443/tcp \
    && ufw enable \
    && ufw reload

# Securing the server: Fail2ban (optional, recommended)
RUN apt-get install fail2ban -y



# Install:
# - git (and git-lfs), for git operations (to e.g. push your work).
#   Also required for setting up your configured dotfiles in the workspace.
# - sudo, while not required, is recommended to be installed, since the
#   workspace user (`gitpod`) is non-root and won't be able to install
#   and use `sudo` to install any other tools in a live workspace.
RUN apt-get update && apt-get install -yq \
    git \
    git-lfs \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# Create the gitpod user. UID must be 33333.
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod

