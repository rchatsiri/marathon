#!/usr/bin/env bash
env


cd marathon-${GIT_TAG}

PKG_TYPE=""
case "$GIT_TAG" in
  *SNAPSHOT*) PKG_TYPE="-unstable";;
  *RC*) PKG_TYPE="-testing";;
esac


dpkg-sig -k E56151BF --sign builder *marathon*.deb
rpm --resign -D "_signature gpg" -D "_gpg_name E56151BF" *marathon*.rpm

echo "Publishing marathon with ${GIT_TAG} ($(ls *)) to ${PKG_TYPE}"


# Debian 8
cp systemd-marathon*.deb ../incoming/debian/jessie${PKG_TYPE}/
# Debian 9
cp systemd-marathon*.deb ../incoming/debian/stretch${PKG_TYPE}/


# Ubuntu 16.04
cp systemd-marathon*.deb ../incoming/ubuntu/yakkety${PKG_TYPE}/
# Ubuntu 16.10
cp systemd-marathon*.deb ../incoming/ubuntu/xenial${PKG_TYPE}/
# Ubuntu 15.10
cp systemd-marathon*.deb ../incoming/ubuntu/wily${PKG_TYPE}/
# Ubuntu 15.04
cp systemd-marathon*.deb ../incoming/ubuntu/vivid${PKG_TYPE}/
# Ubuntu 14.04
cp upstart-marathon*.deb ../incoming/ubuntu/trusty${PKG_TYPE}/
# Ubuntu 12.04
cp upstart-marathon*.deb ../incoming/ubuntu/precide${PKG_TYPE}/

# CentOS6
cp sysvinit-marathon*.rpm ../incoming/el${PKG_TYPE}/6/

# CentOS 7
cp systemd-marathon*.rpm ../incoming/el${PKG_TYPE}/7/
