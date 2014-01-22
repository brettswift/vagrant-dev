#!/bin/bash

# TODO: move to r10k
cd /home/procppt/puppetconfig
#GIT_SSL_NO_VERIFY=true git pull --all
git pull --all
.git/hooks/post-merge