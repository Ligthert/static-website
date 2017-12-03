#!/bin/sh
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
cd /home/outcast/Projects/static-website
/usr/local/bin/mkdocs build
cd /home/outcast/Projects/static-website/site
/usr/bin/aws s3 sync . s3://sacha.ligthert.net
