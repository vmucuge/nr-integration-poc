#!/bin/bash

SCRIPTPATH=$(dirname $BASH_SOURCE)
BUCKETNAME="gcs-startup-scripts"
cd $SCRIPTPATH

echo "Pushing files to Bucket: $BUCKETNAME"
gsutil -m cp -r * gs://$BUCKETNAME/
