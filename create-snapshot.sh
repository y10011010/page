#!/usr/bin/env sh

ls /Volumes/workspace | xargs restic backup --tag $ID
