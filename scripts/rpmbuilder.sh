#!/bin/bash
echo "Install RPM Build Library"
sudo yum install rpm-build
sudo yum install chroot redhat-rpm-config m4 gcc-c++ autoconf automake ncurses-devel wget -y 

mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros
