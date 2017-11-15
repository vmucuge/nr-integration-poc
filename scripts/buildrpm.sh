#!/bin/bash
RPM="${1:-foldersize_integration}"
RPMBUILD="$HOME/rpmbuild"
if [ -z $1 ] ; then
  echo "Set the name of the Package"
  echo "i.e. $0 foldersize_integration"
fi
#cd ~/rpmbuild/SOURCES && spectool -g ../SPECS/foldersize_integration.spec
if [ ! -d $RPMBUILD ] ; then
  ./rpmbuilder.sh
  echo "RPM Build Dirs created"
fi

cd $RPMBUILD
rpmdbuild -bb SPECS/$RPM.spec
