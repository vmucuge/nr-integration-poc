#!/bin/bash
RPMBUILD="$HOME/rpmbuild"
echo "Install RPM Build Library"
sudo yum install rpm-build
sudo yum install chroot redhat-rpm-config m4 gcc-c++ autoconf automake ncurses-devel wget -y

mkdir -p "$RPMBUILD/{BUILD,RPMS,SOURCES,SPECS,SRPMS}"
echo '%_topdir %(echo $HOME)/rpmbuild' > "$HOME/.rpmmacros"
echo '%debug_package %{nil}' >> "$HOME/.rpmmacros"
