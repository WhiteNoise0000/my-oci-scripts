#!/bin/bash
# object storage upload
cd /mnt/hdd/share
cat bkup_target.txt | xargs -i oci os object sync -bn t-bkup --src-dir {} --no-multipart --delete --prefix {}/ --exclude .sync/* --exclude Thumbs.db
