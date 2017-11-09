#!/bin/bash
VERSION=$1
if [ -z $1 ] ; then
  echo "Set the version for the integration"
  exit 1
fi

mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros
mv nr-integrations foldersize-integration-$VERSION
tar czvf foldersize-integration-$VERSION.tar.gz foldersize-integration-$VERSION
mv foldersize-integration-$VERSION.tar.gz ~/rpmbuild/SOURCES
cp specs/foldersize_integration.spec ~/rpmbuild/SPECS/foldersize_integration.spec
sed -i s/VERSION/$VERSION/g ~/rpmbuild/SPECS/foldersize_integration.spec
