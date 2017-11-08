#!/bin/bash

#cd ~/rpmbuild/SOURCES && spectool -g ../SPECS/foldersize_integration.spec
cd ~/rpmbuild
rpmdbuild -bb SPECS/foldersize_integration.spec
