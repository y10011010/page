#!/usr/bin/env sh

cd /Volumes/workspace
rm -rf key.* # build container artifact
ls | grep $ORG | xargs restic backup --tag $ID --tag $ORG
