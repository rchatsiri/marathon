#!/usr/bin/env bash
set -e
set -o pipefail

cd repo/incoming/marathon-${GIT_TAG}

PKG_TYPE=""
case "$GIT_TAG" in
  *SNAPSHOT*) PKG_TYPE="-unstable";;
  *RC*) PKG_TYPE="-testing";;
esac


echo "Publishing marathon with ${GIT_TAG} to ${PKG_TYPE}"

# Debian 8
cp systemd-marathon*.deb $HOME/repo/incoming/debian/jessie${PKG_TYPE}/
# Debian 9
# we don't actually use stretch yet
# cp systemd-marathon*.deb $HOME/repo/incoming/debian/stretch${PKG_TYPE}/


# Ubuntu 16.04
cp systemd-marathon*.deb $HOME/repo/incoming/ubuntu/yakkety${PKG_TYPE}/
# Ubuntu 16.10
cp systemd-marathon*.deb $HOME/repo/incoming/ubuntu/xenial${PKG_TYPE}/
# Ubuntu 15.10
cp systemd-marathon*.deb $HOME/repo/incoming/ubuntu/wily${PKG_TYPE}/
# Ubuntu 15.04
cp systemd-marathon*.deb $HOME/repo/incoming/ubuntu/vivid${PKG_TYPE}/
# Ubuntu 14.04
cp upstart-marathon*.deb $HOME/repo/incoming/ubuntu/trusty${PKG_TYPE}/
# Ubuntu 12.04
cp upstart-marathon*.deb $HOME/repo/incoming/ubuntu/precise${PKG_TYPE}/

# CentOS6
cp sysvinit-marathon*.rpm $HOME/repo/incoming/el${PKG_TYPE}/6/

# CentOS 7
cp systemd-marathon*.rpm $HOME/repo/incoming/el${PKG_TYPE}/7/
