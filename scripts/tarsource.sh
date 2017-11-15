#!/bin/bash
NAME="foldersize_integration"
VERSION="$1"
RPMBUILD="$HOME/rpmbuild"
if [ -z $1 ] ; then
  echo "Set the version for the integration"
  exit 1
fi
if [ ! -d $RPMBUILD ] ; then
  ./rpmbuilder.sh
  echo "RPM Build Dirs created"
fi

mv nr-integrations $NAME-$VERSION
tar czvf $NAME-$VERSION.tar.gz $NAME-$VERSION
mv $NAME-$VERSION.tar.gz $RPMBUILD/SOURCES/
cp specs/$NAME.spec $RPMBUILD/SPECS/$NAME.spec
sed -i s/VERSION/$VERSION/g $RPMBUILD/SPECS/$NAME.spec
